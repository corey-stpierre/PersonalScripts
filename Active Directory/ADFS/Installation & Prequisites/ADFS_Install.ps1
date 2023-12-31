#Install ADFS and Configure
#
#Step 1 - Install ADFS Role
Install-WindowsFeature Adfs-Federation -IncludeManagementTools
#
#Step 2 - Import ADFS PS Module
Import-Module ADFS
#
#Step 3 - Set SPN for ADFS service
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$caption = "Hello!"
$message = "Do you need to set the SPN for the ADFS Service?"
$yesNoButtons = 4

if ([System.Windows.Forms.MessageBox]::Show($message, $caption, $yesNoButtons) -eq "NO") {
"You answered no"
}
else {
"You answered yes"
$SPNHost=Read-Host "Enter the ADFS Farm Name"
$ServiceAccountName=Read-Host "Enter the ADFS Service Account Name (domain\username)"
setspn -a host/$SPNHost $ServiceAccountName
}
#
#Step 4 - Configure Primary ADFS Server
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$caption = "Hello!"
$message = "Is this the Primary ADFS Server?"
$yesNoButtons = 4

if ([System.Windows.Forms.MessageBox]::Show($message, $caption, $yesNoButtons) -eq "NO") {
"You answered no"
}
else {
"You answered yes"
$PrimaryServerCertifiate=Read-Host "Enter the ADFS Farm Certificate Thumbprint"
$FedServiceName=Read-Host "Enter the name of the ADFS Federation Farm"
$ServiceAccount=Get-Credential
Install-AdfsFarm -CertificateThumbprint $PrimaryServerCertifiate -FederationServiceName $FedServiceName -ServiceAccountCredential $ServiceAccount
exit
}
#
#Step 5 - Configure Secondary ADFS Servers
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$caption = "Hello!"
$message = "Is this the Secondary ADFS Server?"
$yesNoButtons = 4

if ([System.Windows.Forms.MessageBox]::Show($message, $caption, $yesNoButtons) -eq "NO") {
"You answered no"
}
else {
"You answered yes"
$PrimaryServerCertifiate=Read-Host "Enter the ADFS Farm Certificate Thumbprint"
$PrimaryComputerName=Read-Host "Enter the name of the Primary ADFS Server"
$ServiceAccount=Get-Credential
Add-AdfsFarmNode -ServiceAccountCredential $ServiceAccount -PrimaryComputerName $PrimaryComputerName -CertificateThumbprint $PrimaryServerCertifiate
exit
}
