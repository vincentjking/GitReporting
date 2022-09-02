. "$PSScriptRoot\..\Config\Config.ps1"
. "$PSScriptRoot\..\Config\Token.ps1"
function Get-GitHubBranchesByRepo
{
    param (
        [Parameter(Mandatory=$true)]
        [string] $branchesURL
    )

    #$token = $config['token']
    $PAT = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($token)"))
    $header = @{'Authorization' = 'Basic ' + $PAT} 
    $response = Invoke-WebRequest $branchesURL -Headers $header | ConvertFrom-Json
    return $response
}

<# Testing
$respBranches = Get-GitHubBranchesByRepo 'https://api.github.com/repos/bank-of-england-technology/img-network-tools/branches?protected=true'
#>