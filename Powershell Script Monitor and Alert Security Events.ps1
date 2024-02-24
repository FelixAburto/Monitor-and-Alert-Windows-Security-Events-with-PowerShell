# PowerShell Script to Monitor and Alert Windows Event Logs

#Start Up Message

Write-Host "Monitoring Windows Event Security Logs"

#Email SMPT Settings

$smtpServer = "smtp-mail.outlook.com"
$smtpPort = 587 
$smtpFrom = ""
$smtpTo = ""
$smtpUser = ""
$smtpPassword = ""

#Secure password

$securePass = ConvertTo-SecureString $smtpPassword -AsPlainText -Force
$smtpCreds = New-Object System.Management.Automation.PSCredential ($smtpUser, $securePass)



# Event IDs to Monitor
$SevEventIDs = @(4720, 4726, 4672, 4732, 4706, 4648, 4657, 4728, 4740, 4756, 4625)

# Account name and domains to exclude
$excludeAccount = "SYSTEM"
$excludeDomain = "NT AUTHORITY"

# Initialize the last event check time to slightly in the past
$eventCheck_Time = (Get-Date).AddSeconds(-10)

# Continuous loop for active monitoring
while ($true) {
    # Fetch Security Events since the last check time
    $SecEvents = Get-WinEvent -FilterHashtable @{LogName="Security"; ID=$SevEventIDs; StartTime=$eventCheck_Time} -MaxEvents 10 -ErrorAction SilentlyContinue

    # Go over each event and process it
    foreach ($event in $SecEvents) {
        # Extract Account Name and Domain Name
        $xmlEvent = [xml]$event.ToXml()
        $accountID = $xmlEvent.Event.EventData.Data | Where-Object { $_.Name -eq "SubjectUserName" } | Select-Object -ExpandProperty '#text'
        $domainID = $xmlEvent.Event.EventData.Data | Where-Object { $_.Name -eq "SubjectDomainName" } | Select-Object -ExpandProperty '#text'

        # Check if the event contains the account and domain to exclude
        if ($accountID -eq $excludeAccount -and $domainID -eq $excludeDomain) {
            continue
        }

        # Process the event
        Write-Host "Event ID: $($event.Id)"
        Write-Host "Time Created: $($event.TimeCreated)"
        Write-Host "Message: $($event.Message)"

         # Email content
         $emailSubject = "Security Event Alert - Event ID: $($event.Id)"
         $emailBody = "Event ID: $($event.Id)`nTime Created: $($event.TimeCreated)`nMessage: $($event.Message)"
 
         # Send email notification
         Send-MailMessage -SmtpServer $smtpServer -Port $smtpPort -From $smtpFrom -To $smtpTo -Subject $emailSubject -Body $emailBody -Credential $smtpCreds -UseSsl
    }

    # Update the last event check time for the next iteration
    if ($SecEvents.Count -gt 0) {
        $eventCheck_Time = $SecEvents[0].TimeCreated.Addseconds(1)
    }

    # Wait a specific time before checking again
    Start-Sleep -Seconds 1
}

