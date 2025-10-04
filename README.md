<h1> 👨‍💻 Lets Play with some PowerShell Scripting for Active Directory</h1>
<h2> 🎈 We are going to create a Domain using a Lab based off of Josh Madakor's Active Directory Home Lab in VirtualBox</h2>
<h2> 🎈 And then create a Powershell Script of our own that can delete the accounts in our AD after a certain amount of Days</h2>

<h2>📑 Resources Used in this Lab/Write-Up</h2>
• <a href="https://youtu.be/MHsI8hJmggI?si=pQBtzyS6Q2OPub0V">Josh Madakor's - Creation of a Home Lab running AD YOUTUBE video </a> <br>
• <a href="https://github.com/joshmadakor1/AD_PS/blob/master/Generate-Names-Create-Users.ps1">Josh Madakor's CREATE_USERS script to create our users for the AD </a> <br>
• <a href="">Script created by ME (Nathan Malaythong) to Banish User Accounts to the SHADOW REALM after a certain amount of Days </a> <br>

<h2>🛠️ Utilities Needed and Programs Used</h2>
<b>• Oracle VirtualBox</b> <br>
<b>• Windows Server ISO Image</b> <br>
<b>• Windows Active Directory</b> <br>
<b>• Windows 10</b> <br>
<b>• PowerShell</b> <br>

<h2>Lets Go!</h2>
<b> ‼️**NOTICE** ‼️ I am going to skip alot of steps in order to condense this write-up down for simplicity, but just refer to J. Madakor's Youtube video for Exact Steps </b> <br>
<h2></h2>

<img width="600" height="300" alt="Image" src="https://github.com/user-attachments/assets/51128e3f-e8c2-46f4-a9ab-d71742892d10" />
<img width="600" height="300" alt="Image" src="https://github.com/user-attachments/assets/294ba4e9-d5d8-4858-a103-da49098777cb" />
<h3>First Download VirtualBox and create your Windows Server Machine </h3>

<h2></h2>

<img width="600" height="300" alt="Image" src="https://github.com/user-attachments/assets/083cc1a4-e4ed-4c70-880b-c2aad09e7e56" />
<h3>Setup your server to Run Active Directory and Create your Custom Domain</h3>
<b>In this case we named our Domain to "KRUSTYKRAB.COM" - I absolutely love Spongebob BTW !</b>

<h2></h2>

<img width="600" height="300" alt="Image" src="https://github.com/user-attachments/assets/21699ddb-f9df-4490-b9f9-fa63e46930a4" />
<h3>Use J. Madakor's CREATE_USER Script to add your list of User's in the Krusty Krab Domain, and create a _USERS Organizational Unit</h3>
<b> ☝️ Explanation on how J. Madakor's script works on adding users to the Domain </b> <br>

```powershell
$PASSWORD_FOR_USERS   = "Password1"
$USER_FIRST_LAST_LIST = Get-Content .\names.txt
```
<b>• creates Default Password for all Accounts using Variable: $Password = "Password1", abnd then creates a variable and pulls in all of the content from the names.txt file</b> <br>

```powershell
$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force
New-ADOrganizationalUnit -Name _USERS -ProtectedFromAccidentalDeletion $false
```
<b>• creates a password variable as a string and assigns it our previous password variable, then creates a new OU in our domain called _USERS </b> <br>

```powershell
foreach ($n in $USER_FIRST_LAST_LIST) {
    $first = $n.Split(" ")[0].ToLower()
    $last = $n.Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower()
    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
```

<b>• Loops through the names.txt Files and splits the Name using the " " Space between names, then stores it as variable $username and logs onto the shell the list newly created users on the GUI</b> <br>

```powershell
    New-AdUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName $username `
               -Name $username `
               -EmployeeID $username `
               -PasswordNeverExpires $true `
               -Path "ou=_USERS,$(([ADSI]`"").distinguishedName)" `
               -Enabled $true
```

<b>• Then creates the User Account in our domain with default attributes </b> <br>

<h2></h2>
<h3></h3>
<img width="600" height="300" alt="Image" src="https://github.com/user-attachments/assets/25478050-f90c-4d3f-a0da-4ad16faa6905" />
<img width="600" height="350" alt="Image" src="https://github.com/user-attachments/assets/bc60443d-0eef-4582-bbba-b71006732ee3" />
<h2>🎉 And BOOM! We have a new set of user's in our Krusty Krab Domain.</h2> <br>
<h1> 📑 Part 2 - Creation of our own script to QUERY & DELETE accounts based on account AGE 📑</h1><br>
<h2>❗ For the next two days, I will add a new set of user's each day ❗ </h2>
<h2>👨‍🔬 and then create a script of our own that can both query & delete user's based the age of the account's</h2>

<img width="600" height="350" alt="Image" src="https://github.com/user-attachments/assets/7f6147a2-7b0c-4a1d-88d2-14ae4f5c1aa7" />

<h2>🛠️ For the next 2 days, I will add a set of user's each day so that we can query user accounts based on their account age. </h2>
<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/f6391e24-67d6-409a-beba-66e731f2e524" /><br>
<b> ☝️For Reference below: </b><br>
<b>• Spongebob User Accounts were created on 10/1. </b><br> 
<b>• Jimmy Neutron User Accounts were created on 10/2.</b><br>
<b>• iCarly  User Accounts were created on 10/3.</b><br>

<h2> 📑 Let's first create a script to list the account's based on account age. </h2>

```powershell
$daysAgo = Read-Host "Enter the number of days ago (e.g., 0 for today, 1 for yesterday, and so on, so on)"

$daysAgo = [int]$daysAgo
```
<b> ☝️ First we create our variable ($daysAgo) and prompt our user to enter the age of the accounts we want to query, then convert that into an integer value </b><br>
<b> • For Example, 0 - would be for accounts added today</b><br> 
<b> • 1 - would be accounts created 1 day ago/yesterday, etc. </b><br>

```powershell
# Calculate date range for the specific day
$startDate = (Get-Date).Date.AddDays(-1 * $daysAgo)
$endDate = $startDate.AddDays(1)
```

<b> ☝️ This function is how we are going to calculate the date/age of the user accounts</b><br>
<b>• .AddDays(-1 * $daysAgo) subtracts the number of days the user entered from Today's date</b><br>
<b>• So $startDate is the very beginning (midnight) of the target day.</b><br>


```powershell
$users = Get-ADUser -SearchBase $ouDN -Filter * -Properties Name, whenCreated
```
<b> ☝️ Grabbing all of the user's in the specified OU (_USERS) with the 'whenCreated' property</b><br>

```powershell
$filteredUsers = $users | Where-Object {
    $_.whenCreated -ge $startDate -and $_.whenCreated -lt $endDate
}
```
<b> ☝️ This function picks out only the users who were created on the exact day we asked for.</b><br>
<b>• $_​.whenCreated = the date the user was created</b><br>
<b>• -ge $startDate = was created on or after the start of the day</b><br>
<b>• -lt $endDate = was created before the start of the next day</b><br>

```powershell
# Output results
if ($filteredUsers.Count -eq 0) {
    Write-Host "No users found created $daysAgo day(s) ago." -ForegroundColor Yellow
} else {
    Write-Host "`nUsers created $daysAgo day(s) ago:`n" -ForegroundColor Cyan
    $filteredUsers | Select-Object Name, whenCreated
}
```

<b> ☝️ Output the user account's if they are found based off account age, if there are no accounts found based on the input, it will output "No users found".</b><br>

<h2>🛠️ NOW! Let's Try it out! </h2>
<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/4f2d20b0-e8a4-407d-80f9-5e8a73182e26" /><br>
<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/cadbb255-f44d-4851-8ad9-f615c25c29fa" /><br>
<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/9707e361-243d-4d4d-8f79-ac63e9b579c7" /><br>

<h2>🎉Woo-hoo! Now that we can query the account's based off age.</h2>
<h2>☝️Let us now Banish them to the shadow realm!</h2>
<b>• We will create a function to delete those accounts out</b><br>
<b>• in a real-world scenario an example could be to "delete account's that are 25 days old, etc."</b><br>

```powershell
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
```
<b>☝️ Prompts user to enter YES if they would like to delete, and then BOOM the accounts are nuked and banished to the SHADOW REALM! </b><br>
<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/a9d64f6a-10b7-4e76-9bd2-3fa0b9c632e6" />
<h2>👨‍🔬Now Lets test it out!</h2>

<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/f6391e24-67d6-409a-beba-66e731f2e524" /><br>
<h2>🛸Here is the current _USERS OU</h2>
<b>❎ Now let's NUKE some accounts BABY!</b>

<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/5825affb-f132-42aa-b25c-a3ef4d5a6905" /><br>
<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/fceb6970-8940-4aa4-a3d9-c03872233ded" /><br>
<b>❎ iCarly Users were banished after selecting INPUT == 0 for user's added today (Today's date 10/3/25, as i'm writing this).</b><br>

<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/9636de9b-568c-4ede-a8c5-cdbafc05bc88" /><br>
<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/bfbdbb2c-75fd-411c-98e3-ae3f463a996c" /><br>
<b>❎ Jimmy Neutron Users were banished after selecting INPUT == 1 for user's added YESTERDAY.</b><br>

<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/f51b078a-7149-479c-97d8-c6a4fa5c0135" /><br>
<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/67cdc989-0a84-4ca3-beca-f94bd7c76379" /><br>
<b>❎ Lastly the OG Spongebob Users were banished after selecting INPUT == 2 for user's added 2 days ago.</b><br>

<h1>🧑‍💻 Thank you for Reading. Gotta Blast!</h1>
<img width="600" height="400" alt="Image" src="https://github.com/user-attachments/assets/bfbaa345-11d7-4106-b0e9-04da9f2c94d4" /><br>








