﻿#Requires -Version 5.0
#Requires -Modules @{ModuleName = "microsoftteams"; ModuleVersion = "1.0.3"}

<#
.SYNOPSIS
    Generates a report with app information from the Teams tenant app store

.DESCRIPTION

.NOTES
    This PowerShell script was developed and optimized for ScriptRunner. The use of the scripts requires ScriptRunner. 
    The customer or user is authorized to copy the script from the repository and use them in ScriptRunner. 
    The terms of use for ScriptRunner do not apply to this script. In particular, ScriptRunner Software GmbH assumes no liability for the function, 
    the use and the consequences of the use of this freely available script.
    PowerShell is a product of Microsoft Corporation. ScriptRunner is a product of ScriptRunner Software GmbH.
    © ScriptRunner Software GmbH

.COMPONENT
    Requires Library Script ReportLibrary from the Action Pack Reporting\_LIB_

.LINK
    https://github.com/scriptrunner/ActionPacks/tree/master/O365/MS-Teams/_REPORTS_
 
.Parameter AppId
    [sr-en] The app's ID generated by Teams (different from the external ID)
    [sr-de] Die von Teams generierte ID der App (unterscheidet sich von der externen ID)

.Parameter ExternalID
    [sr-en] The external ID of the app, provided by the app developer and used by Azure Active Directory
    [sr-de] Externe ID der Anwendung, die vom Entwickler der Anwendung bereitgestellt und von Azure Active Directory verwendet wird
        
.Parameter DisplayName
    [sr-en] Name of the app visible to users
    [sr-de] Anzeigename der App

.Parameter DistributionMethod    
    [sr-en] The type of app in Teams. For LOB apps, use "organization"
    [sr-de] Art der App in Teams. Für LOB-Apps verwenden Sie "organization".
#>

[CmdLetBinding()]
Param(
    [string]$AppId,
    [string]$ExternalID,
    [string]$DisplayName,
    [ValidateSet('organization','global')]
    [string]$DistributionMethod
)

Import-Module microsoftteams

try{
    [string[]]$Properties = @('DisplayName','DistributionMethod','Id','ExternalId')

    [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'}

    if($PSBoundParameters.ContainsKey('AppId')){
        $cmdArgs.Add('Id',$AppId)
    } 
    if($PSBoundParameters.ContainsKey('ExternalID')){
        $cmdArgs.Add('ExternalID',$ExternalID)
    } 
    if($PSBoundParameters.ContainsKey('DisplayName')){
        $cmdArgs.Add('DisplayName',$DisplayName)
    } 
    if($PSBoundParameters.ContainsKey('DistributionMethod')){
        $cmdArgs.Add('DistributionMethod',$DistributionMethod)
    } 

    $result = Get-TeamsApp @cmdArgs | Select-Object $Properties | Sort-Object -Property DisplayName
    ConvertTo-ResultHtml -Result $result
}
catch{
    throw
}
finally{
}