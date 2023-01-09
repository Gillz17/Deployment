$computerName = $env:COMPUTERNAME
$fileLocation = "\\serverName\Image Results\"

$BddLog = "C:\MININT\SMSOSD\OSDLOGS\BDD.log"
$results = gci -Recurse $BddLog | Select-String "type=""(2|3)"""

if($results -ne $null){
    $outputFile = "Failure - $computerName" + (Get-Date).ToString(" MM-dd-yyyy-hh-mm") + ".txt"
    New-Item -ItemType File -Path $fileLocation -Name $outputFile
    
    #Will loop through the errors and strip out just the message we want
    foreach ($ele in $results){
        $ele = $ele -replace ".*\[" -replace "\].*"
        Add-Content $fileLocation$outputFile $ele
    }    
}else{
    $outputFile = "Success - $computerName" + (Get-Date).ToString(" dd-MM-yyyy-hh-mm") + ".txt"
    New-Item -ItemType File -Path $fileLocation -Name $outputFile
}