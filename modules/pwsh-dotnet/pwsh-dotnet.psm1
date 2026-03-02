# pwsh-nvm.psm1
#--------------------------------------------------------------------------------------

#Core paths 
$Script:DotnetRoot   = "C:\ADMIN\dotnet"
$Script:ShimRoot    = "$DotnetRoot\shims"
$Script:CurrentFile = Join-Path $Script:DotnetRoot ".current"

# ---------- Version Listing ----------------------------------------------------------

function Get-DotnetVersions {
    <#
        .SYNOPSIS
            Lists portable dotnet versions 
    #>

    $versions = @()

    # Portable versions
    if(Test-Path $Script:DotnetRoot) {
        $versions += Get-ChildItem -Path $Script:DotnetRoot -Directory |
            Select-Object -ExpandProperty Name
    }

    return $versions
}

# ---------- Current version ----------------------------------------------------

function Get-CurrentDotnetVersion {
    if (Test-Path $Script:CurrentFile) {
        return (Get-Content $Script:CurrentFile -Raw).Trim()
    }
}

function Set-DotnetVersion {
    param([Parameter(Mandatory)][string]$Version)

    Set-Content -Path $Script:CurrentFile -Value $Version -Encoding ascii
}

function Use-DotnetVersion {
    param([Parameter(Mandatory)][string]$Version)

    # ---------- Portable Node----------------------------------------------------
    $target = Join-Path $Script:DotnetRoot $Version

    if (-not (Test-Path $target)) {
        throw "dotnet version '$Version' is not installed under $Script:DotnetRoot"
    }

    # Write state
    Set-DotnetVersion($Version)
    $env:DOTNETROOT = $target

    Write-Host "Switched to dotnet $Version at $target"
}

# ---------- Export --------------------------------------------------------------

Export-ModuleMember -Function *