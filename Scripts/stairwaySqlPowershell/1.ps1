# things learned, sql profile to watch sql runned, all smo operation will produce sql , and only fater alter method is called
# how to call sql , 
#   smo, 
#   sql provider
# 	


Get-WmiObject –computerName localhost –class Win32_PhysicalMemory | Select BankLabel, Capacity

# === loaded SMO as well as the PowerShell Provider for SQL Server.
# SqlServerProviderSnapin100
Get-PSSnapin –registered

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") 
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo.Extended")

# === Stairway to SQL PowerShell Level 3: Input and Output with PowerShell
# Stairway to SQL PowerShell Level 4: Objects in SQL PowerShell
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList "localhost" 
$server.EnumActiveGlobalTraceFlags() 
$server.PingSqlServerVersion(“localhost”)
$server.EnumProcesses($true)| Format-Table -Auto 

# ==== Stairway to SQL PowerShell Level 5: SQL Server PowerShell Building Blocks
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
[System.Reflection.Assembly]::Load("Microsoft.SqlServer.Smo")
[System.Reflection.Assembly]::Load("Microsoft.SqlServer.Smo, Version=10.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91")
[System.Reflection.Assembly]:: LoadFrom("c:\Sample.Assembly.dll")
[System.Reflection.Assembly]:: LoadFile("c:\Sample.Assembly.dll")

Add-Type –AssemblyName "Microsoft.SqlServer.Smo"
Add-Type –AssemblyName "Microsoft.SqlServer.Smo, Version=10.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"

[String]::Format("{0} is a good guy.", "Ben")

Function Get-SqlMaxMemory {
	Param ( [string]$sqlserver )
	
	$sqlconn = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $sqlserver
	
	$maxmem = $sqlconn.Configuration.MaxServerMemory.RunValue
	Write-Output $($maxmem/1MB)
}

$mem=Get-SqlMaxMemory localhost
$($mem / 1GB)

import-module sqlps

$instance = "localhost"
$dbname = "test"
$class = "Microsoft.SqlServer.Management.Smo"

$server = New-Object –TypeName "$class.Server" –Args $instance

$db = $server.Databases[$dbname]

$ds = $db.ExecuteWithResults(“SELECT top 10 * FROM dbo.ticksNoID")

$dt = $ds.Tables[0]

$dt | ft time, volume -Auto

# ========= sqlps
cd SQLSERVER:\SQL\localhost\DEFAULT\Databases

#============ sql get value
$a=Invoke-Sqlcmd -ServerInstanc localhost -Database master -Query "select count(*) as count from
sys.Databases"
PS SQLSERVER:\> $a.count
14