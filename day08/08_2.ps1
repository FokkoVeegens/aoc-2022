$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"

$ErrorActionPreference = 'Break'

$height = $data.Count
$width = $data[0].Length

[int]$highestScenicScore = 0

for ($row = 1; $row -lt $height - 1; $row++) 
{
    for ($col = 1; $col -lt $width - 1; $col++)
    {
        $currentTree = $data[$row].Substring($col, 1)

        # Trees upwards
        [int]$upwards = 0
        for ($rowup = $row - 1; $rowup -ge 0; $rowup--) {
            $upwards++
            if ([int]$data[$rowup].Substring($col, 1) -ge $currentTree)
            {
                break
            }
        }

        # Trees downwards
        [int]$downwards = 0
        for ($rowdown = $row + 1; $rowdown -lt $height; $rowdown++) {
            $downwards++
            if ([int]$data[$rowdown].Substring($col, 1) -ge $currentTree)
            {
                break
            }
        }

        # Visible from the left
        [int]$leftwards = 0
        for ($colleft = $col - 1; $colleft -ge 0; $colleft--) {
            $leftwards++
            if ([int]$data[$row].Substring($colleft, 1) -ge $currentTree)
            {
                break
            }
        }

        # Visible from the right
        [int]$rightwards = 0
        for ($colright = $col + 1; $colright -lt $width; $colright++) {
            $rightwards++
            if ([int]$data[$row].Substring($colright, 1) -ge $currentTree)
            {
                break
            }
        }
        [int]$score = $upwards * $downwards * $leftwards * $rightwards
        if ($score -gt $highestScenicScore)
        {
            $highestScenicScore = $score
        }
    }
}
Write-Host $highestScenicScore