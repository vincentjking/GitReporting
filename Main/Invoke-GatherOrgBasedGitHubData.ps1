. "$PSScriptRoot\..\Config\Config.ps1"
. "$PSScriptRoot\..\ActionScripts\Get-GitHubRepos.ps1"
. "$PSScriptRoot\..\ActionScripts\Get-GitHubBranchesByRepo.ps1"
. "$PSScriptRoot\..\ActionScripts\Get-GitHubProtectionsByBranch.ps1"

function Invoke-GatherOrgBasedGitHubData {
    
    #region  Set constants
    $baseURL = $config['githubURL'] + "/"
    $org = $config['organisation']
    $repoURL = $baseURL + "orgs/" + $org
    
    Write-Host $repoURL

    $respRepos = Get-GitHubRepos $repoURL
<#
    foreach($repo in $respRepos)
    {
        $respRepoURL = $baseURL + "repos/" + $org + $repo.name
        $branchesURL = $baseURL + "repos/" + $org + $repo.name + "/branches"
        Write-Host $respRepoURL
        Write-Host $branchesURL
        $respBranches = Get-GitHubBranchesByRepo $branchesURL

        foreach($branch in $respBranches)
        {
            $branchProtectionURL = $baseURL + "repos/" + $org + $repo.name + "/branches/" + $branch.name + "/protection"
            Write-Host $branchProtectionURL
            #$respBranchProtection = Get-GitHubProtectionsByBranch $branchProtectionURL
            
        }
    }

    return $respBranches
#>
return $respRepos
}

<# Testing #>
$resp = Invoke-GatherOrgBasedGitHubData