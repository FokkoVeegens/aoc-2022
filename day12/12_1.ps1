$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input_test.txt"

$ErrorActionPreference = 'Break'

Class Point {
    [int]$x
    [int]$y
    [string]$val

    Point(
        [int]$x,
        [int]$y,
        [string]$val
    ){
        $this.x = $x
        $this.y = $y
        $this.val = $val
    }
}

[int]$x = 0
[int]$y = 0

$grid = New-Object System.Collections.ArrayList

foreach ($row in $data)
{
    foreach ($letter in $row.ToCharArray())
    {
        $null = $grid.Add([Point]::new($x, $y, $letter))
        $x++
    }
    $x = 0
    $y++
}

$start = $grid | Where-Object { $_.val -ceq "S" }
$end =  $grid | Where-Object { $_.val -ceq "E" }