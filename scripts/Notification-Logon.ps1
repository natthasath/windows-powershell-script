. "$PSScriptRoot\Configuration.ps1"

$header = @{Authorization = $token}

$computer = $env:ComputerName
$obj = query user
foreach ($line in $obj -split '\n') {
    $current = $line -split '\s+'
    $username = $current[0] | Select-String '^>(\w+)' | ForEach-Object { $_.Matches[0].Groups[1].Value }
    $session = $current[1]
    $state = $current[3]
    $logon = ( $current[5] + ' ' + $current[6] )
}

$alert = $username + ' - ' + $logon + ' - ' + $computer
$body = @{message = $alert}
$res = Invoke-RestMethod -Uri $uri -Method Post -Headers $header -Body $body 
echo $res