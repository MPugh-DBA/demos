################################
#                              #
#  Am I Meeting Best Practices #
#                              #
################################

Get-Command Test-* -Module dbatools

## Am I at the latest version? Or within 1SP of the latest version
$instanceSplat = @{
    SqlInstance   = "mssql1", "mssql2"
    SqlCredential = $credential
}
Test-DbaBuild @instanceSplat -Latest
Test-DbaBuild @instanceSplat -MaxBehind 1SP

"mssql1","mssql2" | Test-DbaBuild -SqlCredential $credential -Latest

## Test the compatibility level
Test-DbaDbCompatibility @instanceSplat |
Select-Object SqlInstance, ServerLevel, Database, DatabaseCompatibility, IsEqual |
Format-Table

## Test the database owner
Test-DbaDbOwner @instanceSplat |
Select-Object SqlInstance, Database, DBState, CurrentOwner, TargetOwner, OwnerMatch |
Format-Table

## Test the recovery model  -- default is only full?
Test-DbaDbRecoveryModel @instanceSplat |
Select-Object SqlInstance, Database, ConfiguredRecoveryModel, ActualRecoveryModel |
Format-Table

## Is my tempdb setup to meet best practices?
Test-DbaTempDbConfig @instanceSplat

## Is "max degree of parallelism" set to best practice?
#Inspired by Sakthivel Chidambaram's post about SQL Server MAXDOP Calculator (https://blogs.msdn.microsoft.com/sqlsakthi/p/maxdop-calculator),
Test-DbaMaxDop @instanceSplat

## Is Max Memory set to meet best practices?
#Inspired by Jonathan Kehayias's post about SQL Server Max memory (http://bit.ly/sqlmemcalc)
Test-DbaMaxMemory @instanceSplat |
Select-Object SqlInstance, Total, MaxValue, RecommendedValue

## Dbachecks - automate checking your estate
# https://github.com/sqlcollaborative/dbachecks