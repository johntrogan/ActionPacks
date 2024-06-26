﻿#Requires -Version 5.0
#Requires -Modules @{ModuleName = "microsoftteams"; ModuleVersion = "1.0.3"}

<#
.SYNOPSIS
    Removes an app in the Teams tenant app store

.DESCRIPTION

.NOTES
    This PowerShell script was developed and optimized for ScriptRunner. The use of the scripts requires ScriptRunner. 
    The customer or user is authorized to copy the script from the repository and use them in ScriptRunner. 
    The terms of use for ScriptRunner do not apply to this script. In particular, ScriptRunner Software GmbH assumes no liability for the function, 
    the use and the consequences of the use of this freely available script.
    PowerShell is a product of Microsoft Corporation. ScriptRunner is a product of ScriptRunner Software GmbH.
    © ScriptRunner Software GmbH

.COMPONENT

.LINK
    https://github.com/scriptrunner/ActionPacks/tree/master/O365/MS-Teams/Apps

.Parameter AppId
    [sr-en] The app's ID generated by Teams (different from the external ID)
    [sr-de] Die von Teams generierte ID der App (unterscheidet sich von der externen ID)
#>

[CmdLetBinding()]
Param(
    [Parameter(Mandatory = $true)]   
    [string]$AppId
)

Import-Module microsoftteams

try{
    [string]$disName = Get-TeamsApp -Id $AppId -ErrorAction Stop | Select-Object -Property DisplayName
    $null = Remove-TeamsApp -Id $AppId -ErrorAction Stop
    $result = "App $($disName) in the Teams tenant app store successfully removed"

    if($SRXEnv) {
        $SRXEnv.ResultMessage = $result
    }
    else{
        Write-Output $result
    }
}
catch{
    throw
}
finally{
}