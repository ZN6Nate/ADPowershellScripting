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
<h2>🎉 And BOOM! We have a new set of user's in our Krusty Krab Domain.</h2>
<h2>🤔 Now lets go ahead and add some more user's a couple of days from now</h2>
<h2>🤔 and create a script of our own that can delete user's based x amount of days there account is</h2>

<img width="600" height="350" alt="Image" src="https://github.com/user-attachments/assets/7f6147a2-7b0c-4a1d-88d2-14ae4f5c1aa7" />


















