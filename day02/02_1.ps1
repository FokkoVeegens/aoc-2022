<#
** OPPONENT **
A - Rock
B - Paper
C - Scissors

** YOU **
X - Rock (1)
Y - Paper (2)
Z - Scissors (3)

Win - 6
Draw - 3
Loss - 0
#>

$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"
$scores = @{
    "A X" = 4
    "A Y" = 8
    "A Z" = 3
    "B X" = 1
    "B Y" = 5
    "B Z" = 9
    "C X" = 7
    "C Y" = 2
    "C Z" = 6
}
$data | ForEach-Object { $scores[$_] } | Measure-Object -Sum