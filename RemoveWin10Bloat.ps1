#Zachary McGill
#1/2/2020

#Removes the applications from Windows10 that we do not want
#Use "Get-AppxPackage" or "Get-AppxProvisionedPackage -Online"
#to find the names of the applications to be removed.
#Add the new applications to this list and the script will remove 
#them.
$AppsList = 
'Microsoft.3DBuilder',  
'Microsoft.BingWeather',
'Microsoft.GetHelp',
'Microsoft.Messaging',
'Microsoft.Microsoft3DViewer',
'Microsoft.MicrosoftSolitaireCollection',
'Microsoft.People', 
'Microsoft.Windows.Photos', 
'Microsoft.WindowsCamera',
'microsoft.windowscommunicationsapps', 
'Microsoft.WindowsPhone',
'Microsoft.WindowsSoundRecorder', 
'Microsoft.XboxApp', 
'Microsoft.ZuneMusic',
'Microsoft.ZuneVideo', 
'Microsoft.Getstarted', 
'Microsoft.WindowsFeedbackHub',
'Microsoft.XboxIdentityProvider', 
'Microsoft.MixedReality.Portal',
'Microsoft.MSPaint',
'Microsoft.Office.OneNote',
'Microsoft.OneConnect',
'Microsoft.Print3D',
'Microsoft.SkypeApp',
'Microsoft.StorePurchaseApp',
'Microsoft.Wallet',
'Microsoft.WindowsAlarms',
'Microsoft.WindowsMaps',
'Microsoft.WindowsStore',
'Microsoft.Xbox.TCUI',
'Microsoft.XboxGameOverlay',
'Microsoft.XboxGamingOverlay',
'Microsoft.XboxSpeechToTextOverlay',
'Microsoft.YourPhone',
'Microsoft.MicrosoftOfficeHub'

ForEach ($App in $AppsList){
    $PackageFullName = (Get-AppxPackage $App).PackageFullName
    $ProPackageFullName = (Get-AppxProvisionedPackage -online | where {$_.Displayname -eq $App}).PackageName
    write-host $PackageFullName
    Write-Host $ProPackageFullName
    if ($PackageFullName){
        Write-Host "Removing Package: $App"
        remove-AppxPackage -package $PackageFullName
    }
    else{
        Write-Host "Unable to find package: $App"
    }
    if ($ProPackageFullName){
        Write-Host "Removing Provisioned Package: $ProPackageFullName"
        Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName
    }
    else{
        Write-Host "Unable to find provisioned package: $App"
    }
}

#Remove Quick Assist 
Remove-WindowsCapability -online -name App.Support.QuickAssist~~~~0.0.1.0

#Remove OneDrive
#taskkill /f /im OneDrive.exe
#%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall