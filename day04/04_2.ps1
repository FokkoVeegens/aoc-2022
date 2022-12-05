$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt" -Raw
$data = $data -replace "-", ","
$data = $data -split "\r\n"

$indexStartOne = 0
$indexEndOne = 1
$indexStartTwo = 2
$indexEndTwo = 3

$count = 0
foreach ($row in $data)
{
    $rowItems = $row -split ","
    if (([int]$rowItems[$indexEndOne] -ge [int]$rowItems[$indexStartTwo] -and [int]$rowItems[$indexEndOne] -le [int]$rowItems[$indexEndTwo]) -or `
        ([int]$rowItems[$indexStartOne] -le [int]$rowItems[$indexEndTwo] -and [int]$rowItems[$indexStartOne] -ge [int]$rowItems[$indexStartTwo]) -or `
        ([int]$rowItems[$indexStartTwo] -ge [int]$rowItems[$indexStartOne] -and [int]$rowItems[$indexStartTwo] -le [int]$rowItems[$indexEndOne]) -or `
        ([int]$rowItems[$indexStartOne] -ge [int]$rowItems[$indexStartTwo] -and [int]$rowItems[$indexStartOne] -le [int]$rowItems[$indexEndTwo]))
    {
        $count++
    }
}
Write-Host $count