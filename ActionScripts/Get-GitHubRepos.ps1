. "$PSScriptRoot\..\Config\Config.ps1"
. "$PSScriptRoot\..\Config\Token.ps1"

function Get-GitHubRepos
{
    param (
        [Parameter(Mandatory=$true)]
        [string] $repoURL
    )

    #$token = $config['token']
    $PAT = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($token)"))

    $allRepos = @()
    $page=2 # should be 0!
    do 
    {    
        $page += 1    
        $params = @{'Uri' = ('{0}/repos?page={1}&per_page=100' -f
                                $repoURL, $page )
                    'Headers' = @{'Authorization' = 'Basic ' + $PAT}                
                    'Method'      = 'GET'                
                    'ContentType' = 'application/json'}    
        $repos = Invoke-RestMethod @params   
        $allRepos += $repos    
        $repoCount = $repos.Count 
    } while($repoCount -gt 0)

    return $allRepos
}

<# Testing 
$resp = Get-GitHubRepos https://api.github.com/orgs/bank-of-england-technology
$resp | Select-Object -Property name
$resp.count
#>