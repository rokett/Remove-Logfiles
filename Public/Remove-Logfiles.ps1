function Remove-Logfiles() {
    [CmdletBinding()]
    Param(
        [int]$OlderThan = 30,

        [string]$Extension = 'log',

        [Parameter(Mandatory=$True)]
        [string]$Path
    )

    BEGIN {
        $OlderThan = '-' + $OlderThan
        $Extension = '*.' + $Extension
        $Path = $path + '\*'

        If (![System.Diagnostics.EventLog]::SourceExists('Remove-Logfiles')) {
            New-EventLog -LogName Application -Source 'Remove-Logfiles'
        }

        $Date = (Get-Date).AddDays($OlderThan)

        $LogEntry = @()
    }

    PROCESS {
        try {
            $Files = Get-ChildItem -File -Filter $Extension -Path $Path | Where-Object {!$_.PSIsContainer -and $_.CreationTime -lt $Date}
            $Files | Remove-Item

            $LogEntry += 'Housekeeping complete for ' + $Path
            $LogEntry += ''
            $LogEntry += 'Extension: ' + $Extension
            $LogEntry += 'Older than: ' + $OlderThan + ' day(s) old'
            $LogEntry += ''
            $LogEntry += 'Deleted the following files:'

            $DeletedFiles = $Files | ForEach-Object { $_.FullName } | Out-String
            $LogEntry += '- ' + $DeletedFiles

            $EntryType = 'Information'
        } catch {
            $_.Exception | Format-List -Force

            $LogEntry += 'Error deleting logfiles of type *.' + $Exception + ' over ' + $OlderThan + ' day(s) old'
            $LogEntry += $_.Exception

            $EntryType = 'Error'
        } finally {
            $LogEntry = $LogEntry | Out-String
            Write-EventLog -LogName Application -Source 'Remove-Logfiles' -EntryType $EntryType -EventId 1 -Message $LogEntry
        }
    }

    END {}
}
