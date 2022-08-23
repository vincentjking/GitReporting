. "$PSScriptRoot\..\Config\Config.ps1"
. "$PSScriptRoot\..\ActionScripts\Get-GitHubRepos.ps1"
. "$PSScriptRoot\..\ActionScripts\Get-GitHubBranchesByRepo.ps1"

function Invoke-GatherOrgBasedGitHubData {
#https://api.github.com/orgs/bank-of-england/repos
    #region  Set constants
    $baseURL = $config['githubURL'] + "/"
    $org = $config['organisation'] + "/"
    $token = $config['token']
    $headers = @{Authorization="Bearer $token"}
    
    $repoURL = $baseURL + "orgs/" + $org + "repos"
    
    $respRepos = Get-GitHubRepos $repoURL

    foreach($repo in $respRepos)
    {
        $branchesURL = $baseURL + "repos/" + $org + $repo.name + "/branches"
        Write-Host $branchesURL
        $respBranches = Get-GitHubBranchesByRepo $branchesURL

        foreach($branch in $respBranches)
        {
            $branchProtectionURL = $baseURL + "repos/" + $org + $repo.name + "/branches/" + $branch.name
            $respBranchProtection = (Invoke-WebRequest -Uri $branchProtectionURL `
                -Header $headers `
                -Method GET -ContentType "application/json").content `
                | ConvertFrom-Json
            Write-Host $respBranchProtection
        }
    }

    Write-Host $repoURL

    return $respRepos
}

<# Testing #>
$resp = Invoke-GatherOrgBasedGitHubData