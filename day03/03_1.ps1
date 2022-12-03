$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"
$lowerCaseAsciiCodeForA = 97
$upperCaseAsciiCodeForZ = 90

$lowerCaseAsciiOffset = 96
$upperCaseAsciiOffset = 38
$score = 0

foreach ($row in $data)
{
    $arr1 = [string]$row.Substring(0, $row.Length/2).ToCharArray() -split " "
    $arr2 = [string]$row.Substring($row.Length/2).ToCharArray() -split " "
    $result = Compare-Object -IncludeEqual -ReferenceObject $arr1 -DifferenceObject $arr2 -CaseSensitive | Where-Object { $_.SideIndicator -eq "==" }
    $letter = $result.InputObject[0]
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