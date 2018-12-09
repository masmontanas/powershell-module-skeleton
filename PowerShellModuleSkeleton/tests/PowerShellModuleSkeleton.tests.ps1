# set working path
$pathtest = Split-Path $MyInvocation.MyCommand.path -Parent
Set-Location $pathtest

# get public functions to ensure that they're being exported correctly in meta context
$publicfunctions = @()
$functions = Get-ChildItem ..\public
$functions.name | ForEach-Object {
    $split = $_.split('.')
    $publicfunctions += $split[0]
}

# end config, start unit-tests.

# All tests for PowerShellModuleSkeleton module
Describe PowerShellModuleSkeleton {

    # meta tests for module
    Context meta {
    
        It "Should Import" {
        
            { Import-Module ..\PowerShellModuleSkeleton -ErrorAction Stop } | Should Not Throw
            
        }


        $module = Get-Module PowerShellModuleSkeleton
        $publicfunctions | ForEach-Object {
        
            It "Should export function ' $_ ' in public folder" {
            
                $module.ExportedCommands.Keys -contains $_  | Should Be $true
            
            }
        
        }

    }

    # todo: unit tests for function
    Context Test-PublicFunction {
    
    }

}