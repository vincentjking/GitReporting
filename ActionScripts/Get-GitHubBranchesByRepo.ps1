. "$PSScriptRoot\..\Config\Config.ps1"

function Get-GitHubBranchesByRepo
{
    param (
        [Parameter(Mandatory=$true)]
        [string] $branchesURL
    )

    $token = $config['token']
    $PAT = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($token)"))
    
    $response = Invoke-WebRequest $branchesURL | ConvertFrom-Json
    return $response
}

<# Testing 
$respBranches = Get-GitHubBranchesByRepo 'CVEDigest'
#>