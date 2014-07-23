# Housekeeper

Housekeeper is a Powershell script used to delete files after a user defined number of days.

Housekeeper defaults to deleting all *.log files in a user specified location which are older than 30 days.

When Housekeeper finishes, whether it has deleted anything or not, it will write an entry to the Application Event Log to say that it is complete.

## Usage

The following examples will delete all *.tmp files which are older than 3 days.

### From within a Powershell console

Assuming you are already in the directory where the Housekeeper script lives.

    .\housekeeper.ps1 -path c:\path\to\logs -extension tmp -days 3

### From the command line

    powershell -ExecutionPolicy RemoteSigned -NoProfile -File c:\scripts\housekeeper.ps1 -path c:\path\to\logs -extension tmp -days 3

## Requirements
A minimum of PowerShell 3.0 is required for this script to work.