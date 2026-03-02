# ensure portable env setup before invoking PSEdition specific profile
Import-Module "C:\myenv\Ensure-Env" -ErrorAction SilentlyContinue
Initialize-PortableEnvironment

# Determine module root based on PS edition
if ($PSVersionTable.PSEdition -eq 'Core') {
    $moduleRoot = "C:\myenv\Modules.PS7"
    $profileScript = Join-Path $moduleRoot "pwsh.profile.ps1"
} else {
    $moduleRoot = "C:\myenv\Modules.PS5"
    $profileScript = Join-Path $moduleRoot "ps.profile.ps1"
}

# Rebuild the PSModulePath deterministically
$env:PSModulePath = @(
    $moduleRoot
    "$PSHOME\Modules"
    "C:\Windows\System32\WindowsPowerShell\v1.0\Modules"
) -join ';'

# Load per-edition profile
if ( Test-Path $profileScript) {
    . $profileScript
} else {
    Write-Host "ERROR: Expected profile script not found: $profileScript" -ForegroundColor Red
}

# ==================================== end portable env choice ===================================

# this helps cmd/git bash/powershell play nice
$env:HOME = $env:USERPROFILE

