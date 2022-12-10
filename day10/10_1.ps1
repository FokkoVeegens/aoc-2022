$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"

[int]$cycle = 0
[int]$X = 1

$signalStrengths = New-Object System.Collections.ArrayList
$null = $signalStrengths.Add(0)

foreach ($row in $data)
{
    $cycle++
    if ($row -eq "noop")
    {
        $null = $signalStrengths.Add($cycle * $X)
        continue
    }

    $null = $signalStrengths.Add($cycle * $X)

    $cycle++
    $null = $signalStrengths.Add($cycle * $X)
    $X += [int]$row.Substring(5)
}
[int[]]$cyclesToMeasure = 20, 60, 100, 140, 180, 220
[int]$totalSignalStrenght = 0
foreach ($curcycle in $cyclesToMeasure)
{
    $totalSignalStrenght += $signalStrengths[$curcycle]
}


Write-Host $totalSignalStrenght