$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"

$ErrorActionPreference = 'Break'

$height = $data.Count
$width = $data[0].Length
$numberOfCornerTrees = 4

[int]$visibleTrees = 2 * $height + 2 * $width - $numberOfCornerTrees

for ($row = 1; $row -lt $height - 1; $row++) 
{
    for ($col = 1; $col -lt $width - 1; $col++)
    {
        $currentTree = $data[$row].Substring($col, 1)
        $currentTreeIsVisible = $true

        # Visible from the top
        for ($rowup = $row - 1; $rowup -ge 0; $rowup--) {
            if ([int]$data[$rowup].Substring($col, 1) -ge $currentTree)
            {
                $currentTreeIsVisible = $false
                break
            }
        }
        if ($currentTreeIsVisible)
        {
            $visibleTrees++
            continue
        }
        else 
        {
            $currentTreeIsVisible = $true
        }

        # Visible from the bottom
        for ($rowdown = $row + 1; $rowdown -lt $height; $rowdown++) {
            if ([int]$data[$rowdown].Substring($col, 1) -ge $currentTree)
            {
                $currentTreeIsVisible = $false
                break
            }
        }
        if ($currentTreeIsVisible)
        {
            $visibleTrees++
            continue
        }
        else 
        {
            $currentTreeIsVisible = $true
        }

        # Visible from the left
        for ($colleft = $col - 1; $colleft -ge 0; $colleft--) {
            if ([int]$data[$row].Substring($colleft, 1) -ge $currentTree)
            {
                $currentTreeIsVisible = $false
                break
            }
        }
        if ($currentTreeIsVisible)
        {
            $visibleTrees++
            continue
        }
        else 
        {
            $currentTreeIsVisible = $true
        }

        # Visible from the right
        for ($colright = $col + 1; $colright -lt $width; $colright++) {
            if ([int]$data[$row].Substring($colright, 1) -ge $currentTree)
            {
                $currentTreeIsVisible = $false
                break
            }
        }
        if ($currentTreeIsVisible)
        {
            $visibleTrees++
            continue
        }
    }
}
Write-Host $visibleTrees