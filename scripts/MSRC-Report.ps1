. "$PSScriptRoot\Configuration.ps1"

Set-MSRCApiKey -ApiKey $secret_key -Verbose

Get-MsrcCvrfDocument -ID $interest -Verbose | 
Get-MsrcSecurityBulletinHtml -Verbose | 
Out-File $report_msrc