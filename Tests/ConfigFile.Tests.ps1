BeforeAll{
    . $PSScriptRoot\..\Config\Config.ps1
}

Describe 'Config Files' {
    Context 'Check Default (Dev) Config File'{
        It 'BaseURL not null or empty' {
            $config['githubURL'] | Should -Not -BeNullOrEmpty
        }

        It 'userName not null or empty' {
            $config['userName'] | Should -Not -BeNullOrEmpty
        }
    }
}