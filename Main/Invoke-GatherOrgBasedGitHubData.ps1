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
$allUnprotectedBrances = @()
    foreach($repo in $respRepos)
    {
        $respRepoURL = $baseURL + "repos/" + $org + "/" + $repo.name
        $branchesURL = $baseURL + "repos/" + $org + "/" + $repo.name + "/branches"
        $unprotectedBranchesURL = $baseURL + "repos/" + $org + "/" + $repo.name + "/branches?protected=false"
        Write-Host $respRepoURL
        Write-Host $branchesURL
        Write-Host $unprotectedBranchesURL
        $respBranches = Get-GitHubBranchesByRepo $unprotectedBranchesURL
        $allUnprotectedBrances += $respBranches
        Write-Host $respBranches
<#
        foreach($branch in $respBranches)
        {
            $branchProtectionURL = $baseURL + "repos/" + $org + $repo.name + "/branches/" + $branch.name + "/protection"
            Write-Host $branchProtectionURL
            #$respBranchProtection = Get-GitHubProtectionsByBranch $branchProtectionURL
            
        }
 #>
    }

    return $allUnprotectedBrances

#return $respRepos
}

<# Testing #>
$resp = Invoke-GatherOrgBasedGitHubData