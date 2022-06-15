. "$PSScriptRoot\Configuration.ps1"

$filelist = Get-ChildItem $path_video -filter *.avi -recurse

$num = $filelist | measure
$filecount = $num.count

$i = 0;
ForEach ($file in $filelist)
{
    $i++;
    $oldfile = $file.DirectoryName + "\" + $file.BaseName + $file.Extension;
    $newfile = $file.DirectoryName + "\" + $file.BaseName + ".mp4";
     
    $progress = ($i / $filecount) * 100
    $progress = [Math]::Round($progress,2)

    Clear-Host
    Write-Host -------------------------------------------------------------------------------
    Write-Host Handbrake Batch Encoding 
    Write-Host "Processing - $oldfile"
    Write-Host "File $i of $filecount - $progress%"
    Write-Host -------------------------------------------------------------------------------

    Start-Process "HandBrakeCLI.exe" -ArgumentList "-i `"$oldfile`" -o `"$newfile`" -f mp4 -e x264 -q 22 -r 30 -B 352 -X 1152 -O" -Wait -NoNewWindow
}