<#
** OPPONENT **
A - Rock (1)
B - Paper (2)
C - Scissors (3)

** YOU **
X - Loss
Y - Draw
Z - Win

Win - 6
Draw - 3
Loss - 0
#>

$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"
$scores = @{
    "A X" = 3 # C
    "A Y" = 4 # A
    "A Z" = 8 # B
    "B X" = 1 # A
    "B Y" = 5 # B
    "B Z" = 9 # C
    "C X" = 2 # B
    "C Y" = 6 # C
    "C Z" = 7 # A
}
$data | ForEach-Object { $scores[$_] } | Measure-Object -Sum