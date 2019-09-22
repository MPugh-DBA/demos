## 1. Get the module

# Install a module from the PowerShell Gallery
Install-Module dbatools

# Save a module and then copy it to a machine without internet access
Save-Module dbatools c:\temp

## 2. Update a module from the PowerShell Gallery
Update-Module dbatools

## 3. Import a module
Import-Module dbatools

## 4. List modules currently imported into your session
Get-Module dbatools
## 1.0.47

## 5. List module versions that are available
Get-Module dbatools -ListAvailable

## 6. Find available commands
# All commands available within dbatools
Get-Command -Module dbatools

# All commands that have compression in the name
Get-Command *Compression* -Module dbatools

## BONUS for finding commands
Find-DbaCommand *compression*
Find-DbaCommand -Author Pomfret

## 7. Get help on how to use a command
Get-Help Test-DbaDbCompression
Get-Help Test-DbaDbCompression -ShowWindow

## 8. Intro to Splatting
$splatGet = @{
    SqlInstance     = "mssql1"
    SqlCredential   = $Credential
    Database        = "AdventureWorks2017"
}
Get-DbaDbCompression @splatGet | Select-Object -first 5