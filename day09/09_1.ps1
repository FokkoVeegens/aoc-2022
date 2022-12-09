$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"

Class VisitedPosition {
    [int]$x
    [int]$y
}

$headX = 0
$headY = 0
$tailX = 0
$tailY = 0

$VisitedPositionsArr = @("0_0")

foreach ($row in $data) {
    $amount = [int]$row.Substring(2)

    for ($i = 0; $i -lt $amount; $i++) {
        $xOffset = $tailX - $headX
        $yOffset = $tailY - $headY
        switch ($row[0]) {
            "U" { 
                $headY++
                if ($yOffset -eq -1) {
                    $tailY++
                    if ($xOffset -ne 0) {
                        $tailX += $xOffset * -1
                    }
                }
            }
            "D" {
                $headY--
                if ($yOffset -eq 1) {
                    $tailY--
                    if ($xOffset -ne 0) {
                        $tailX += $xOffset * -1
                    }
                }
            }
            "R" {
                $headX++
                if ($xOffset -eq -1) {
                    $tailX++
                    if ($yOffset -ne 0) {
                        $tailY += $yOffset * -1
                    }
                }
            }
            "L" {
                $headX--
                if ($xOffset -eq 1) {
                    $tailX--
                    if ($yOffset -ne 0) {
                        $tailY += $yOffset * -1
                    }
                }
            }
        }
    
        $VisitedPositionsArr += "$($tailX)_$($tailY)"
    }
}
Write-Host ($VisitedPositionsArr | Select-Object -Unique).Count