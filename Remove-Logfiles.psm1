$scriptRoot = $PSScriptRoot + '\public'

Get-ChildItem $scriptRoot *.ps1 | %{ Import-Module $_.FullName }