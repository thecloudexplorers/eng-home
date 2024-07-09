# winget import usage guide
## Basic guidance
Please refer to the Microsoft Learn description to understand how the winget tool works for instsallation of packages:
[https://learn.microsoft.com/en-us/deployoffice/overview-office-deployment-tool](https://learn.microsoft.com/en-us/windows/package-manager/winget/)

# Config file
I've provided [an example JSON configuration file](./winget/winget-core-config-business-x64.json) which I utilize to provision the base required packages (for me) on a new machine. Feel free to tweak this however you need it for your personal preferences, it's just an example to get you started.

## Editing config file
If you wish to change any part of the configuration, do so in the JSON file directly. Simply use winget to seearch for packages as desired:
- `winget search [[-q] \<query>] [\<options>]`
- For example, `winget search VSCode`, if you want to look for the Package Identifier for Visual Studio Code.
- winget will display the package as listed in the winget repo.
- Copy & paste the desired winget Package Identifier in the JSON file you will use to import.

## Usage
Please refer to the specific Microsoft Learn descriptions to export & import winget packages in bulk:
[https://learn.microsoft.com/en-us/windows/package-manager/winget/export](https://learn.microsoft.com/en-us/windows/package-manager/winget/export)
[https://learn.microsoft.com/en-us/windows/package-manager/winget/import](https://learn.microsoft.com/en-us/windows/package-manager/winget/import)

The steps to initiate an install of packages as defined in a winget configuration file are as follows:
- Place the `config.json` file in an accesible location on your local drive;
- Open a Windows Terminal, or other commandline interface in Windows;
- Run the command from commandline in the working directory: `winget import [-i] <import-file> [<options>]`.
