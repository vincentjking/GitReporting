. "$PSScriptRoot\..\Config\Config.ps1"
. "$PSScriptRoot\..\ActionScripts\Get-GitHubRepos.ps1"
. "$PSScriptRoot\..\ActionScripts\Get-GitHubBranchesByRepo.ps1"

function Invoke-GatherUserBasedGitHubData {

    #region  Set constants
    $baseURL = $config['githubURL'] + "/"
    $owner = $config['userName'] + "/"
    $token = $config['token']
    $headers = @{Authorization="Bearer $token"}

    $repoURL = $baseURL + "users/" + $owner + "repos"
    Write-Host $repoURL
    $respRepos = Get-GitHubRepos $repoURL

    foreach($repo in $respRepos)
    {
        $branchesURL = $baseURL + "repos/" + $owner + $repo.name + "/branches"
        Write-Host "BranchURL: " $branchesURL
        $respBranches = Get-GitHubBranchesByRepo $branchesURL

        foreach($branch in $respBranches)
        {
            $branchProtectionURL = $baseURL + "repos/" `
                + $owner `
                + $repo.name `
                + "/branches/" + $branch.name `
                + "/protection"
            Write-Host "branchProtectionURL: " $branchProtectionURL
            $respBranchProtection = (Invoke-WebRequest -Uri $branchProtectionURL `
                -Header $headers `
                -Method GET -ContentType "application/json").content `
                | ConvertFrom-Json
            Write-Host $respBranchProtection
        }
    }
    return $respBranchProtection
}

<# Testing #>
$resp = Invoke-GatherUserBasedGitHubData