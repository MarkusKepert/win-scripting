# compress logfiles older than x days
# initial 2014-06-05 MN

$Sourcedir = 'D:\Program Files (x86)\hMailServer\Logs'
$datediff = 2
[string]$Zip = $Sourcedir + "\7za.exe"; #path to 7Zip executable

# get files older than two days
#$files = gci $Sourcedir -recurse | ? {$_.lastwritetime -gt (get-date).adddays(-2)}
$now = Get-Date
$days = 2
$lastWrite = $now.AddDays(-$days)

Get-ChildItem $targetFolder -Filter '*.log' -Recurse | Where-Object { $_ -is [System.IO.FileInfo] } | ForEach-Object {
	If ($_.LastWriteTime -lt $lastWrite)
	{
    
		foreach($file in $_)
		{
				[array]$arguments = "a", "-tzip", "-y", $file.BaseName, $file.FullName;
				& $Zip $arguments ;
		}
	}
}
