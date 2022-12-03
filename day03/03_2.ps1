$ErrorActionPreference = 'Break'
$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"
$lowerCaseAsciiCodeForA = 97
$upperCaseAsciiCodeForZ = 90

$lowerCaseAsciiOffset = 96
$upperCaseAsciiOffset = 38

$score = 0

for ($i = 0; $i -lt $data.Count; $i+=3) 
{
    $arr1 = $data[$i].ToCharArray() -split " "
    $arr2 = $data[$i+1].ToCharArray() -split " "
    $arr3 = $data[$i+2].ToCharArray() -split " "
    $firstresult = (Compare-Object -IncludeEqual -ReferenceObject $arr1 -DifferenceObject $arr2 -CaseSensitive | Where-Object { $_.SideIndicator -eq "==" }).InputObject
    $secondresult = (Compare-Object -IncludeEqual -ReferenceObject $firstresult -DifferenceObject $arr3 -CaseSensitive | Where-Object { $_.SideIndicator -eq "==" }).InputObject
    $letter = $secondresult[0]
    $charnum = [byte][char]$letter

    if ($charnum -ge $lowerCaseAsciiCodeForA)
    {
        # Lowercase
        $score += $charnum - $lowerCaseAsciiOffset
    }
    if ($charnum -le $upperCaseAsciiCodeForZ)
    {
        # Uppercase
        $score += $charnum - $upperCaseAsciiOffset
    }
}
Write-Host "Score: $score"