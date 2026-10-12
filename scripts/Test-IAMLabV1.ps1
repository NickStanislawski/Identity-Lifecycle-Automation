
# Enterprise Identity Lifecycle Automation Lab
# Final V1 Validation

Import-Module ActiveDirectory -ErrorAction Stop

$Employees = @(Import-Csv "C:\IAM-Lab\Data\employees.csv")
$UserOU = "OU=Users,OU=IAM-Lab,DC=iamlab,DC=test"
$GroupOU = "OU=Groups,OU=IAM-Lab,DC=iamlab,DC=test"

$RoleMap = @{
    "HR Specialist"            = "ROLE-HR-Specialist"
    "HR Manager"               = "ROLE-HR-Manager"
    "Staff Accountant"         = "ROLE-FIN-StaffAccountant"
    "Finance Director"         = "ROLE-FIN-Director"
    "Sales Specialist"         = "ROLE-SALES-Specialist"
    "Sales Manager"            = "ROLE-SALES-Manager"
    "Software Engineer"        = "ROLE-ENG-SoftwareEngineer"
    "Senior Software Engineer" = "ROLE-ENG-SeniorEngineer"
    "Engineering Manager"      = "ROLE-ENG-Manager"
    "IT Support Specialist"    = "ROLE-IT-Support"
    "Systems Administrator"    = "ROLE-IT-SysAdmin"
    "IT Manager"               = "ROLE-IT-Manager"
}

$ADUsers = @(Get-ADUser -Filter * -SearchBase $UserOU `
    -Properties EmployeeID, Department, Title, Manager, Enabled)

$ADGroups = @(Get-ADGroup -Filter * -SearchBase $GroupOU)

$Failures = [System.Collections.Generic.List[string]]::new()
$Validated = 0

# Check total counts
if ($Employees.Count -ne 50) {
    $Failures.Add("CSV employee count is not 50")
}

if ($ADUsers.Count -ne 50) {
    $Failures.Add("AD user count is not 50")
}

if ($ADGroups.Count -ne 12) {
    $Failures.Add("AD group count is not 12")
}

$UsersByID = @{}
foreach ($User in $ADUsers) {
    if (-not $User.EmployeeID) {
        $Failures.Add("AD user missing EmployeeID: $($User.SamAccountName)")
        continue
    }
    if ($UsersByID.ContainsKey($User.EmployeeID)) {
        $Failures.Add("Duplicate AD EmployeeID: $($User.EmployeeID)")
    }
    $UsersByID[$User.EmployeeID] = $User
}

$GroupsByName = @{}
foreach ($Group in $ADGroups) {
    $GroupsByName[$Group.Name] = $Group
}

$Memberships = @{}
foreach ($Group in $ADGroups) {
    $Memberships[$Group.Name] = @(
        Get-ADGroupMember -Identity $Group
    )
}

foreach ($Employee in $Employees) {

    if (-not $UsersByID.ContainsKey($Employee.EmployeeID)) {
        $Failures.Add("Missing user: $($Employee.EmployeeID)")
        continue
    }

    $User = $UsersByID[$Employee.EmployeeID]
    $Valid = $true

    # Verify identity attributes
    if ($User.Name -ne $Employee.Name -or
        $User.SamAccountName -ne $Employee.Username -or
        $User.Department -ne $Employee.Department -or
        $User.Title -ne $Employee.Position) {
        $Failures.Add("Attribute mismatch: $($Employee.EmployeeID)")
        $Valid = $false
    }

    # Verify departmental OU
    $ExpectedOU = "OU=$($Employee.Department),$UserOU"

    if (-not $User.DistinguishedName.EndsWith(
        ",$ExpectedOU",
        [System.StringComparison]::OrdinalIgnoreCase
    )) {
        $Failures.Add("Incorrect OU: $($Employee.EmployeeID)")
        $Valid = $false
    }

    # Verify role group membership
    if (-not $RoleMap.ContainsKey($Employee.Position)) {
        $Failures.Add("Unmapped role: $($Employee.EmployeeID)")
        $Valid = $false
    }
    else {
        $Role = $RoleMap[$Employee.Position]

        if (-not $GroupsByName.ContainsKey($Role)) {
            $Failures.Add("Missing group: $Role")
            $Valid = $false
        }
        elseif (-not @($Memberships[$Role] | Where-Object {
            $_.DistinguishedName -eq $User.DistinguishedName
        }).Count) {
            $Failures.Add("Missing RBAC membership: $($Employee.EmployeeID)")
            $Valid = $false
        }
    }

    # Verify manager relationship
    if ($Employee.Manager) {
        if (-not $UsersByID.ContainsKey($Employee.Manager)) {
            $Failures.Add("Missing manager: $($Employee.EmployeeID)")
            $Valid = $false
        }
        elseif ($User.Manager -ne $UsersByID[$Employee.Manager].DistinguishedName) {
            $Failures.Add("Incorrect manager: $($Employee.EmployeeID)")
            $Valid = $false
        }
    }
    elseif ($User.Manager) {
        $Failures.Add("Unexpected manager: $($Employee.EmployeeID)")
        $Valid = $false
    }

    # Verify expected account state
    $ExpectedEnabled = ($Employee.EmployeeID -eq "EMP001")
    if ($User.Enabled -ne $ExpectedEnabled) {
        $Failures.Add("Incorrect account state: $($Employee.EmployeeID)")
        $Valid = $false
    }

    if ($Valid) {
        $Validated++
    }
}

Write-Host ""
Write-Host "========== FINAL V1 VALIDATION =========="
Write-Host "CSV employees: $($Employees.Count)"
Write-Host "AD users: $($ADUsers.Count)"
Write-Host "AD role groups: $($ADGroups.Count)"
Write-Host "Fully validated employees: $Validated"
Write-Host "Validation failures: $($Failures.Count)"

if ($Failures.Count -gt 0) {
    Write-Host ""
    $Failures | ForEach-Object {
        Write-Host "FAIL: $_" -ForegroundColor Red
    }
    exit 1
}

Write-Host "RESULT: PASS" -ForegroundColor Green

