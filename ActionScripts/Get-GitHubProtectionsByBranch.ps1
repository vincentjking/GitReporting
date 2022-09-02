. "$PSScriptRoot\..\Config\Config.ps1"
. "$PSScriptRoot\..\Config\Token.ps1"
function Get-GitHubProtectionsByBranch
{
    param (
        [Parameter(Mandatory=$true)]
        [string] $branchProtectionURL
    )

    $token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($token)"))
    $headers = @{authorization = "Basic $token"}

    Write-Host $branchProtectionURL

    #$respBranchProtection = (Invoke-WebRequest -Uri $branchProtectionURL -Header $headers -Method GET -ContentType "application/json").content | ConvertFrom-Json
    #$respBranchProtection = Invoke-WebRequest -Uri $branchProtectionURL -Header $headers -Method GET -ContentType "application/json"
    $respBranchProtection = Invoke-RestMethod -Uri $branchProtectionURL -Method Get -ContentType "application/json" -Headers $headers
#$response = Invoke-WebRequest $branchProtectionURL | ConvertFrom-Json
    return $respBranchProtection
}

<# Testing
$respBranches = Get-GitHubProtectionsByBranch https://api.github.com/repos/bank-of-england/Shapley_regressions/branches/master/protection
#>