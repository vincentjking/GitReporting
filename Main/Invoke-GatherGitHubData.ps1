. "$PSScriptRoot\..\Config\Config.ps1"
. "$PSScriptRoot\..\ActionScripts\Get-GitHubRepos.ps1"
. "$PSScriptRoot\..\ActionScripts\Get-GitHubBranchesByRepo.ps1"

function Invoke-GatherGitHubData {

    #region  Set constants
    $baseURL = $config['githubURL'] + "/"
    $owner = $config['userName'] + "/"

    $repoURL = $baseURL + "users/" + $owner + "repos"
    $respRepos = Get-GitHubRepos $repoURL

    foreach($repo in $respRepos)
    {
        $branchesURL = $baseURL + "repos/" + $owner + $repo.name + "/branches"
        Write-Host $branchesURL
        #$respBranches = Get-GitHubBranchesByRepo $branchesURL
    }
    return $respRepos
}

<# Testing #>
$resp = Invoke-GatherGitHubData