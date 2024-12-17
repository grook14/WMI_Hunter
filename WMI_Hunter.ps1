                                                                                                                                            
#   _/          _/       _/      _/       _/_/_/                    _/    _/                                _/                                
#  _/          _/       _/_/  _/_/         _/                      _/    _/      _/    _/      _/_/_/    _/_/_/_/       _/_/       _/  _/_/   
# _/    _/    _/       _/  _/  _/         _/                      _/_/_/_/      _/    _/      _/    _/    _/         _/_/_/_/     _/_/        
#  _/  _/  _/         _/      _/         _/                      _/    _/      _/    _/      _/    _/    _/         _/           _/           
#   _/  _/           _/      _/       _/_/_/                    _/    _/        _/_/_/      _/    _/      _/_/       _/_/_/     _/            
#                                                                                                                                             
#                                                  _/_/_/_/_/  

$ConsumerSubscription =  @()
$ConsumerDefault =  @()


$WMI_ObjectSubscription = Get-WMIObject -Namespace root\Subscription -Class __EventConsumer
$WMI_ObjectDefault = Get-WMIObject -Namespace root\Default -Class __EventConsumer

#If no data is found for either command, the script terminates
if ($WMI_ObjectSubscription -eq $null -and $WMI_ObjectDefault -eq $null) {break}

# This portion gets the information for the "Subscription" portion of WMI entries
foreach ($w in $WMI_ObjectSubscription) {
    $class = $w.__CLASS;
    $nameSpace = $w.__NAMESPACE
    $computerName = $w.PSComputerName;
    $commandLine = $w.CommandLineTemplate;
    $path = $w.__PATH;
    $name = $w.Name

    # Checks if the command line field is blank, if it is, it moves to the next entry in the array
    if ($commandLine -eq $null) {continue}
    
    # creates an object based on the data from the WMI entry output
    $ConsumerSubscription += [PSCustomObject]@{
        cmd = $commandLine;
        Name = $name;
        Computer_Name = $computerName;
        Class = $class;
        NameSpace = $nameSpace;
        Path = $path;
    }
    $ConsumerSubscription
    # EventID 7401
    Write-EventLog -LogName <TODO> -Source "<TODO>" -EventId <TODO> -Message "TH - WMI Consumer Detected - root/Subscription `nCommandline: $commandLine" -EntryType Information 
}

# This portion gets the information for the "Default" portion of WMI entries
foreach ($w in $WMI_ObjectDefault) {
    $class = $w.__CLASS;
    $nameSpace = $w.__NAMESPACE
    $computerName = $w.PSComputerName;
    $commandLine = $w.CommandLineTemplate;
    $path = $w.__PATH;
    $name = $w.Name
    
    # creates an O=object based on the data from the WMI entry output
    $ConsumerDefault += [PSCustomObject]@{
        cmd = $commandLine;
        Name = $name;
        Computer_Name = $computerName;
        Class = $class;
        NameSpace = $nameSpace;
        Path = $path;
    }
    $ConsumerDefault
    # EventID 74001
    Write-EventLog -LogName <TODO> -Source "<TODO>" -EventId <TODO> -Message "TH - WMI Consumer Detected - root/Default `nCommandline: $commandLine" -EntryType Information

}

$ConsumerSubscription | Format-Table
$ConsumerDefault | Format-Table
