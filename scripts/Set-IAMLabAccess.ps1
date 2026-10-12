
# Enterprise Identity Lifecycle Automation Lab
# Configure RBAC memberships and manager relationships

Import-Module ActiveDirectory -ErrorAction Stop

$Employees = @(Import-Csv "C:\IAM-Lab\Data\employees.csv")
$GroupOU = "OU=Groups,OU=IAM-Lab,DC=iamlab,DC=test"
$UserOU = "OU=Users,OU=IAM-Lab,DC=iamlab,DC=test"

# Position to security group mapping
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

$Users = @{}
$Groups = @{}
$ErrorsFound = 0
$RoleAssignments = 0
$ManagerAssignments = 0

# Load AD users and index by EmployeeID
foreach ($User in Get-ADUser -Filter * -SearchBase $UserOU -Properties EmployeeID, Manager) {
    if ($User.EmployeeID) {
        if ($Users.ContainsKey($User.EmployeeID)) {
            throw "Duplicate AD EmployeeID: $($User.EmployeeID)"
        }
        $Users[$User.EmployeeID] = $User
    }
}

# Load role groups
foreach ($Group in Get-ADGroup -Filter * -SearchBase $GroupOU) {
    $Groups[$Group.Name] = $Group
}

# Validate prerequisites before making changes
foreach ($Employee in $Employees) {
    if (-not $Users.ContainsKey($Employee.EmployeeID)) {
        throw "Missing AD user: $($Employee.EmployeeID)"
    }

    if (-not $RoleMap.ContainsKey($Employee.Position)) {
        throw "Unmapped position: $($Employee.Position)"
    }

    $Role = $RoleMap[$Employee.Position]

    if (-not $Groups.ContainsKey($Role)) {
        throw "Missing AD group: $Role"
    }

    if ($Employee.Manager -and -not $Users.ContainsKey($Employee.Manager)) {
        throw "Missing manager: $($Employee.Manager)"
    }
}

# Cache existing direct group memberships
$GroupMembers = @{}

foreach ($Role in ($RoleMap.Values | Sort-Object -Unique)) {
    $MemberIDs = @{}

    foreach ($Member in @(Get-ADGroupMember -Identity $Groups[$Role])) {
        $MemberIDs[$Member.DistinguishedName] = $true
    }

    $GroupMembers[$Role] = $MemberIDs
}

# Configure employees
foreach ($Employee in $Employees) {
    $User = $Users[$Employee.EmployeeID]
    $Role = $RoleMap[$Employee.Position]

    try {
        # Assign role membership if missing
        if (-not $GroupMembers[$Role].ContainsKey($User.DistinguishedName)) {
            Add-ADGroupMember -Identity $Groups[$Role] -Members $User -ErrorAction Stop
            $GroupMembers[$Role][$User.DistinguishedName] = $true
        }

        $RoleAssignments++

        # Set manager relationship if applicable
        if ($Employee.Manager) {
            $Manager = $Users[$Employee.Manager]

            if ($User.Manager -ne $Manager.DistinguishedName) {
                Set-ADUser -Identity $User -Manager $Manager -ErrorAction Stop
            }

            $ManagerAssignments++
        }

        Write-Host "SUCCESS: $($Employee.EmployeeID) | $Role" -ForegroundColor Green
    }
    catch {
        $ErrorsFound++
        Write-Host "FAILED: $($Employee.EmployeeID) | $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "========== CONFIGURATION SUMMARY =========="
Write-Host "Employees processed: $($Employees.Count)"
Write-Host "Successful role assignments: $RoleAssignments"
Write-Host "Successful manager assignments: $ManagerAssignments"
Write-Host "Errors: $ErrorsFound"
