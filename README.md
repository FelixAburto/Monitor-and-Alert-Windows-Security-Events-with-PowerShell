<h1>Monitor and Alert Windows Security Events with Powershell</h1>

<h2>Description</h2>
This project consists of a PowerShell script used to monitor and alert certain windows security events such as Event ID: 4720, 4726, 4672, 4732, 4706, 4648, 4657, 4728, 4740, 4756, and 4625. To showcase this I will be demonstrating how the script alerts when a new user account is created on the system.

<br />***Note: all email addresses displayed in this project are dummy email addresses and will be deleted afterwards*** <br />

<br />***Note: The user has to change the execution policy in order for the script to function properly. They can do this by inputing this command: "Set-ExecutionPolicy RemoteSigned"*** <br />


<br />


<h2>Languages Used</h2>

- <b>PowerShell</b> 

<h2>Environments Used </h2>

- <b>Windows 11</b> (23H2)

<h2>Program walk-through:</h2>

<p align="center">
Running the script: <br/>
<img src="https://i.imgur.com/MWkZET3.png" height="100%" width="100%" alt="Disk Sanitization Steps"/>
<br />
<br />
Output screen when script is running:  <br/>
<img src="https://i.imgur.com/tIp3Wcr.png" height="100%" width="100%" alt="Disk Sanitization Steps"/>
<br />
<br />
Creating a user account to alert on event 4720: <br/>
<img src="https://i.imgur.com/AtTgOEA.png" height="100%" width="100%" alt="Disk Sanitization Steps"/>
<br />
<br />
Windows Security Event is displayed on the terminal:  <br/>
<img src="https://i.imgur.com/22gH6Su.png" height="100%" width="100%" alt="Disk Sanitization Steps"/>
<br />
<br />
After the script detects a security event it will send an email alert:  <br/>
<img src="https://i.imgur.com/Z1Ss0P5.png" height="100%" width="100%" alt="Disk Sanitization Steps"/>
<br />
<br />

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
