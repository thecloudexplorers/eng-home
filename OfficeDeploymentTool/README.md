# Office Deployment Tool usage guide
## Basic guidance
Please refer to the Microsoft Learn description to understand how the Office Deployment Tool (ODT) works:
https://learn.microsoft.com/en-us/deployoffice/overview-office-deployment-tool

## Editing GUI
If you wish to change any part of the configuration through a wizard GUI, please find the Office Configuration editor (import & export) here:
https://config.office.com/deploymentsettings

## Office Deployment Tool setup package
In order to run the setup with the custom configuration file please download the latest version:
https://www.microsoft.com/en-us/download/details.aspx?id=49117

You need to extract that package, which contains several example configuration files and the setup.exe.

## Usage
The steps to initiate the Office setup with a custom configuration file are as follows:
- Place the setup.exe file from the latest ODT setup package in your preferred working directory;
- Place the desired configuration XML file in the same working directory;
- Run the command from commandline in the working directory: .\setup.exe /configure configuration-yourfile.xml
