$dir = (Get-Item -Path $MyInvocation.MyCommand.Path).Directory.FullName
$data = Get-Content -Path "$dir\input.txt"

[int]$diskSpace = 70000000
[int]$unusedSpaceTarget = 30000000

$dirs = @{
    "/" = 0
}

$currentDir = ""
foreach ($row in $data)
{
    if ($row -eq "$ cd /")
    {
        $currentDir = "/"
        continue
    }
    if ($row -eq "$ cd ..")
    {
        $currentDir = $currentDir.Substring(0, $currentDir.LastIndexOf("/"))
        if ($currentDir -eq [string]::Empty)
        {
            $currentDir = "/"
        }
        continue
    }
    if ($row -like "$ cd *")
    {
        if ($currentDir -eq "/")
        {
            $currentDir += $row.Replace("$ cd ", "")
        }
        else 
        {
            $currentDir += "/" + $row.Replace("$ cd ", "")    
        }
        
        if (!$dirs.ContainsKey($currentDir))
        {
            $dirs.Add($currentDir, 0)
        }
        continue
    }
    if ($row -eq "$ ls")
    {
        continue
    }
    if ($row -like "dir *")
    {
        continue
    }

    $dirsToUpdate = $currentDir.Split("/")
    if ($dirsToUpdate.Length -eq 2 -and $dirsToUpdate[1] -eq [string]::Empty)
    {
        $dirsToUpdate = $dirsToUpdate[0]
    }
    for ($i = 0; $i -lt $dirsToUpdate.Count; $i++) 
    {
        $dirToUpdate = $dirsToUpdate[0..$i] -join "/"
        if ($dirToUpdate -eq "")
        {
            $dirToUpdate = "/"
        }
        $dirs[$dirToUpdate] += [int]($row.Split(" ")[0])
    }
}
[int]$usedSpace = $dirs["/"]
[int]$freeSpace = $diskSpace - $usedSpace
[int]$bytesToRemove = $unusedSpaceTarget - $freeSpace

$dirs.Values | Sort-Object | Where-Object { $_ -ge $bytesToRemove } | Select-Object -First 1