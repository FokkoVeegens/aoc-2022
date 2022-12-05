Param (
    [Parameter(Mandatory=$true)]    
    [string]$daynum
)
$basedir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$daydir = "$basedir\day$daynum"

Push-Location
New-Item -Path $daydir -ItemType Directory -Force | Set-Location
$null = New-Item -Path ".\$($daynum)_1.ps1" -ItemType File
$null = New-Item -Path ".\$($daynum)_2.ps1" -ItemType File
$null = New-Item -Path ".\input.txt" -ItemType File
$null = New-Item -Path ".\input_test.txt" -ItemType File