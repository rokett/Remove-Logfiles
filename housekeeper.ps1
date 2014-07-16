param(
    [int]$days = 30,
    [string]$extension = "*.log",
    [parameter(Mandatory = $true)][string]$path
)

$days = "-" + $days
$path = $path + "\*"

$date = (Get-Date).AddDays($days)

# Delete files older than the $date.
Get-ChildItem -Path $path -Include $extension | Where-Object {!$_.PSIsContainer -and $_.CreationTime -lt $date} | Remove-Item

# Logging
if (![System.Diagnostics.EventLog]::SourceExists('Housekeeper')) {
    New-EventLog -LogName Application -Source Housekeeper
}

$message = 'Housekeeping complete for ' + $path

Write-EventLog -LogName Application -Source Housekeeper -EntryType Information -EventId 1 -Message $message