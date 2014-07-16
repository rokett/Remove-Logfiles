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
