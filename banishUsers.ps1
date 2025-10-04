#Using PowerShell w/ Active Directory 
#By: Nathan Malaythong

# Import the AD Module
Import-Module ActiveDirectory

# Prompt the user to enter the number of days ago (e.g., 0 for today, 1 for yesterday)
$daysAgo = Read-Host "Enter the number of days ago (e.g., 0 for today, 1 for yesterday, and so on)"

# Convert to integer
$daysAgo = [int]$daysAgo

# Define the DN of the _USERS OU
$ouDN = "OU=_USERS,DC=krustykrab,DC=com"

# Calculate date range for the specific day
$startDate = (Get-Date).Date.AddDays(-1 * $daysAgo)
$endDate = $startDate.AddDays(1)

# Get all users in the specified OU with the 'whenCreated' property
$users = Get-ADUser -SearchBase $ouDN -Filter * -Properties Name, whenCreated

# Filter users created on the specified day
$filteredUsers = $users | Where-Object {
    $_.whenCreated -ge $startDate -and $_.whenCreated -lt $endDate
}

# Output results
if ($filteredUsers.Count -eq 0) {
    Write-Host "No users found created $daysAgo day(s) ago." -ForegroundColor Yellow
} else {
    Write-Host "`nUsers created $daysAgo day(s) ago:`n" -ForegroundColor Cyan
    $filteredUsers | Select-Object Name, whenCreated
    

#Confirm before deletion
    $confirm = Read-Host "`nDo you want to delete these users? Type 'YES' to confirm"

    if ($confirm -eq 'YES') {
        $filteredUsers | ForEach-Object {
            Remove-ADUser -Identity $_ -Confirm:$false
            Write-Host "Deleted user: $($_.Name)" -ForegroundColor Red
        }
    } else {
        Write-Host "No users were deleted." -ForegroundColor Green
    }
}
