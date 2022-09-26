Import-module msrcsecurityupdates

# General Setting
$Global:root = "..\"
$Global:date = Get-Date -Format yyyyMMdd
$Global:month = Get-Date -Format MMM
$Global:year = Get-Date -Format yyyy
$Global:interest = $year + '-' + $month

# Handbrake
$Global:path_video = '..\video'

# MSRC Report
$Global:report_msrc = $root + 'MSRC\report-' + $date + '.html'
$Global:secret_key = 'IOOcQITxbtHaLJ9QMXqRFm2vfaDhvwIdCQg8v9z2T9n'

# Notification Logon
$Global:uri = 'https://notify-api.line.me/api/notify'
$Global:token = 'Bearer xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'