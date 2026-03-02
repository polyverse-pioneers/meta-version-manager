# pwsh-nvm.psm1
#--------------------------------------------------------------------------------------

#Core paths 
$Script:NodeRoot   = "C:\ADMIN\node-versions"
$Script:ShimRoot    = "C:\ADMIN\shims"
$Script:CurrentFile = Join-Path $Script:NodeRoot ".current"

# ---------- System Node Detection ----------------------------------------------------

function Get-SystemNode {
    <#
        .SYNOPSIS
            Detects the system-installed Node.js (if any)

        .DESCRIPTION
            Returns a hashtable describing the system Node installation,
            but only if it is NOT the shimmed version.

            This allows the module to treat "system" as a read-only version
            that can be selected but not installed or removed.
    #>

    $cmd = Get-Command node.exe -ErrorAction SilentlyContinue

    if(-not $cmd){
        return $null
    }

    return @{
        Version     = "system"
        Path        = $cmd.Source
        ReadOnly    = $true
    }
}

# ---------- Version Listing ----------------------------------------------------------

function Get-NodeVersions {
    <#
        .SYNOPSIS
            Lists portable Node versions plus the system version (if present)
    #>

    $versions = @()

    # Portable versions
    if(Test-Path $Script:NodeRoot) {
        $versions += Get-ChildItem -Path $Script:NodeRoot -Directory |
            Select-Object -ExpandProperty Name
    }

    # System version
    $sys = Get-SystemNode
    if ($sys) {
        $versions += $sys.Version
    }
    return $versions
}

# ---------- Current version ----------------------------------------------------

function Get-CurrentNodeVersion {
    if (Test-Path $Script:CurrentFile) {
        return (Get-Content $Script:CurrentFile -Raw).Trim()
    }
}

function Set-NodeVersion {
    param([Parameter(Mandatory)][string]$Version)

    Set-Content -Path $Script:CurrentFile -Value $Version -Encoding ascii
}

# ---------- Switching Versions (stub for now) -----------------------------------

function Use-NodeVersion {
    param([Parameter(Mandatory)][string]$Version)

    # ---------- System Node ----------------------------------------------------
    if ($Version -eq "system") {
        $sys = Get-SystemNode
        if(-not $sys) {
            throw "System Node not found"
        }

        # Write state
        Set-Content -Path $Script:CurrentFile -Value "system" -Encoding ascii

        # Update NODE_PATH to use system Node folder
        $env:NODE_PATH = Split-Path $sys.Path -Parent

        Write-Host "Switched to system Node at $($sys.Path)"
        return
    }

    # ---------- Portable Node----------------------------------------------------
    $target = Join-Path $Script:NodeRoot $Version

    if (-not (Test-Path $target)) {
        throw "Node version '$Version' is not installed under $Script:NodeRoot"
    }

    # Write state
    $env:NODE_PATH = $target

    Write-Host "Switched to Node $Version at $target"
}

# ---------- Export --------------------------------------------------------------

Export-ModuleMember -Function *