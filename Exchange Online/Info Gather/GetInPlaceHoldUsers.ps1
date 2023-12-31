#Get List of Users on In-Place Hold
#Created by Corey St. Pierre
#
#
#Step 1 - Connect to Exchange Online through the Windows Azure Active Directory PowerShell Module
#You will be asked to put your Exchange Online Administrative Username and Password in for security
#
#
Import-Module MSOnline
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
#
#
#Step 2 - Get current mailboxes in e-Discovery Search
mkdir C:\InPlaceResults\
$searchname = Read-Host 'Enter the Name of the eDiscovery Search'
(Get-MailboxSearch "$searchname").sourceMailboxes > C:\InPlaceResults\in-placehold.csv