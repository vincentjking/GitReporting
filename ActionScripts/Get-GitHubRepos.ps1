. "$PSScriptRoot\..\Config\Config.ps1"

function Get-GitHubRepos
{
    param (
        [Parameter(Mandatory=$true)]
        [string] $repoURL
    )

    $response = Invoke-WebRequest $repoURL | ConvertFrom-Json
    return $response

}

<# Testing 
$resp = Get-GitHubRepos
#>