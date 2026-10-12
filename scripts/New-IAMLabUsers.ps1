# Enterprise Identity Lifecycle Automation Lab
# Script: New-IAMLabUsers.ps1
# Purpose: Provision simulated employees into Active Directory

[CmdletBinding(SupportsShouldProcess = $true)]
param()

Import-Module ActiveDirectory -ErrorAction Stop

$CsvPath = "C:\IAM-Lab\Data\employees.csv"
$BaseOU  = "OU=Users,OU=IAM-Lab,DC=iamlab,DC=test"

$Employees = @(Import-Csv -Path $CsvPath -ErrorAction Stop)

# Map departments to their respective OUs
$DepartmentOUs = @{
    HR          = "HR"
    Finance     = "Finance"
    Sales       = "Sales"
    Engineering = "Engineering"
    IT          = "IT"
}

# Validate the employee dataset before processing
if ($Employees.Count -ne 50) {
    throw "Expected 50 employee records. Found $($Employees.Count)."
}

$RequiredFields = @(
    "Name", "EmployeeID", "Department",
    "Position", "HireDate", "EmploymentStatus", "Username"
)

foreach ($Employee in $Employees) {
    foreach ($Field in $RequiredFields) {
        if ([string]::IsNullOrWhiteSpace($Employee.$Field)) {
            throw "Employee record contains a missing required field: $Field"
        }
    }

    if (-not $DepartmentOUs.ContainsKey($Employee.Department)) {
        throw "Unknown department: $($Employee.Department)"
    }
}

foreach ($Field in @("EmployeeID", "Username")) {
    $Duplicates = $Employees |
        Group-Object -Property $Field |
        Where-Object Count -gt 1

    if ($Duplicates) {
        throw "Duplicate values detected for $Field."
    }
}

# Check for existing accounts before creating new ones
foreach ($Employee in $Employees) {

    $Username = $Employee.Username
    $EmployeeID = $Employee.EmployeeID

    $ExistingUser = Get-ADUser -Filter {
        SamAccountName -eq $Username -or EmployeeID -eq $EmployeeID
    } -ErrorAction Stop

    if ($ExistingUser) {
        Write-Host "SKIPPED: $Username already exists or EmployeeID is assigned." -ForegroundColor Yellow
        continue
    }

    $TargetOU = "OU=$($DepartmentOUs[$Employee.Department]),$BaseOU"

    $FirstName, $LastName = $Employee.Name -split ' ', 2

    $Parameters = @{
        Name                 = $Employee.Name
        GivenName            = $FirstName
        Surname              = $LastName
        SamAccountName       = $Username
        UserPrincipalName    = "$Username@iamlab.test"
        EmployeeID           = $EmployeeID
        Department           = $Employee.Department
        Title                = $Employee.Position
        Description          = "Hire Date: $($Employee.HireDate); Status: $($Employee.EmploymentStatus)"
        Path                 = $TargetOU
        Enabled              = $false
        ErrorAction          = "Stop"
    }

    try {
        if ($PSCmdlet.ShouldProcess($Username, "Create AD user in $TargetOU")) {
            New-ADUser @Parameters

            Write-Host "CREATED: $Username" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "FAILED: $Username - $($_.Exception.Message)" -ForegroundColor Red
    }
}