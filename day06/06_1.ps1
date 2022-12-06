$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"

$startOfPacketMarkerLength = 4

for ($i = 0; $i -lt $data.Length; $i++) {
    $chars = $data.Substring($i, $startOfPacketMarkerLength).ToCharArray()
    $uniquechars = $chars | Select-Object -Unique
    $result = Compare-Object -ReferenceObject $chars -DifferenceObject $uniquechars
    if (!($result | Where-Object { $_.SideIndicator -eq "<=" -or $_.SideIndicator -eq ">=" }))
    {
        Write-Host ($i + $startOfPacketMarkerLength)
        break
    }
}