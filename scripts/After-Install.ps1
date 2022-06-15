$Global:computer_name = "WIN2K12"
$Global:adapter_name = "NET 10.10.10.0"
$Global:ip_address = "10.10.10.2"
$Global:ip_subnet = "24"
$Global:ip_gateway = "10.10.10.1"
$Global:dns_primary = "10.10.10.101"
$Global:dns_secondary = "10.10.10.102"
$Global:time_zone = "SE Asia Standard Time"
$Global:short_date = "d/M/yyyy"
$Global:short_time = "H:mm"
$Global:long_date = "dddd, MMMM d, yyyy"
$Global:long_time = "H:mm:ss"
$Global:day_of_week = "0"
$Global:domain = "lab.local"
$Global:credential = "LAB\Administrator"

## Set Computer Name
Rename-Computer -NewName $computer_name

## Set IP Address
$netadapter = Get-NetAdapter | Select Name
Rename-NetAdapter -Name $netadapter.Name -NewName $adapter_name

$status = (Get-NetIPAddress -InterfaceIndex 12 | Where-Object {$_.AddressFamily -eq 'IPv4'} -ErrorAction Stop).IPAddress

If ($status -eq $null) {

    New-NetIPAddress -InterfaceIndex 12 -IPAddress $ip_address -PrefixLength $ip_subnet -DefaultGateway $ip_gateway
    Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddress ($dns_primary, $dns_secondary)

}

## Set Time Zone
tzutil /s $time_zone

## Set Date Time
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortDate -value $short_date
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortTime -value $short_time
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sLongDate -value $long_date
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sTimeFormat -value $long_time
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name iFirstDayOfWeek -Value $day_of_week;

## Set Language
$lang = Get-WinUserLanguageList
$lang.Add("th-TH")
Set-WinUserLanguageList -LanguageList $lang -Force

## Enable Remote Desktop
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

## Enable ICMP
netsh firewall set icmpsetting 8

## Disable Windows Update
sc.exe config wuauserv start=disabled
sc.exe stop wuauserv

## Join Domain
Add-Computer -DomainName $domain -Credential $credential

## Restart Computer
Restart-Computer