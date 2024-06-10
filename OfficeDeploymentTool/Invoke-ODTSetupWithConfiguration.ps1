#TODO: add formal scripting structure, including script instructions and parameters.

$setupFilePath = ".\setup.exe"
$configurationFilePath = "configuration-x64.business.xml"

& $setupFilePath /configure $configurationFilePath
