<h1> 👨‍💻 Lets Play with some PowerShell Scripting for Active Directory</h1>
<h2> • We are going to create a Domain using a Lab based off of Josh Madakor's Active Directory Home Lab in VirtualBox</h2>
<h2> • And then create a Powershell Script of our own that can delete the accounts in our AD after a certain amount of Days</h2>

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
<b>• creates Default Password for all Accounts using Variable: $Password = "Password1"</b> <br>
<b>• creates a new OU in our domain called _USERS </b> <br>
<b>• Loops through the .TXT Files of names and splits the Name using the " " Space between names</b> <br>
<b>• Then creates the User Account in our domain with default attributes </b> <br>

<h2></h2>



















