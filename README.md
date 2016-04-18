# Remove-Logfiles

Remove-Logfiles is a Powershell module used to delete files after a user defined number of days.

Remove-Logfiles defaults to deleting all *.log files in a user specified location which are older than 30 days.

When Remove-Logfiles finishes, whether it has deleted anything or not, it will write an entry to the Application Event Log to say that it is complete.

## Usage

**NOTE:** This module MUST be run as an administrator, at least on the first run, as it creates a new Event Log source.

The following examples will delete all *.tmp files which are older than 3 days.

First you need to import the module:

    Import-Module Remove-Logfiles

Then you can call the cmdlet to delete logfiles:

    Remove-Logfiles -Path c:\path\to\logs -Extension tmp -OlderThan 3

## Requirements
A minimum of PowerShell 3.0 is required for this module to work.