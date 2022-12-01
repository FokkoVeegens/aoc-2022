$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt" -Raw
$data = $data -replace "\r\n\r\n", "|"
$data = $data -replace "\r\n", ","
$elves = $data -split "\|"
$elves | ForEach-Object { $_ -split "," | Measure-Object -Sum } | ForEach-Object { $_.Sum } | Sort-Object -Descending | Select-Object -First 3 | Measure-Object -Sum