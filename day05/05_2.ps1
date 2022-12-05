$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"

$stackNumbersLine = $data | Where-Object { $_.Trim().StartsWith("1") }
$stackNumbersArray = $stackNumbersLine.Trim() -split " "
$numberOfStacks = [int]($stackNumbersArray[$stackNumbersArray.GetUpperBound(0)])
$stacks = [string[]]::new($numberOfStacks)

$crateColumnOffset = 4

foreach ($row in $data)
{
    if ($row.Trim().StartsWith("1"))
    {
        break
    }
    for ($i = 0; $i -lt $stacks.Count; $i++) {
        $crate = $row.Substring(($i * $crateColumnOffset) + 1, 1).Trim()
        if ($crate)
        {
            $stacks[$i] += $crate
        }
    }
}

$moveData = $data | Where-Object { $_.StartsWith("move") }
foreach ($row in $moveData)
{
    $vectors = $row.Replace("move ", "").Replace(" from ", ",").Replace(" to ", ",").Split(",")
    $amountOfCrates = [int]$vectors[0]
    $fromStackIndex = ([int]$vectors[1]) - 1
    $toStackIndex = ([int]$vectors[2]) - 1

    $cratesToMove = $stacks[$fromStackIndex].Substring(0, $amountOfCrates)
    $stacks[$fromStackIndex] = $stacks[$fromStackIndex].Substring($amountOfCrates)
    $stacks[$toStackIndex] = $cratesToMove + $stacks[$toStackIndex]
}
foreach ($stack in $stacks)
{
    Write-Host $stack.Substring(0, 1) -NoNewline
}
Write-Host "`n"