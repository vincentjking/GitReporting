. "$PSScriptRoot\..\Config\Config.ps1"

function Get-GitHubBranchesByRepo
{
    param (
        [Parameter(Mandatory=$true)]
        [string] $branchesURL
    )

    $response = Invoke-WebRequest $branchesURL | ConvertFrom-Json
    return $response
}

<# Testing 
$respBranches = Get-GitHubBranchesByRepo 'CVEDigest'
#>