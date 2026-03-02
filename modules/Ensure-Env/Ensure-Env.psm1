function Initialize-PortableEnvironment {

    $portableBase = "C:\ADMIN"
    $dotnetBase = "$portableBase\dotnet"
    $nodeBase = "$portableBase\nodejs"
    $pythonBase = "$portableBase\python"
    $pwshBase = "$portableBase\pwsh7"

    # Rebuild PATH (runtime only) 
    $portablePaths = @(
        $pwshBase
        "$nodeBase\shims"
        "$pythonBase\shims"
        "$dotnetBase\shims"
    )

    foreach ($p in $portablePaths) {
        if ($env:PATH -notmatch [regex]::Escape($p)) {
            $env:PATH = "$p;$env:PATH"
        }
    }

    # setx commands here if we want Windows user env vars to work

    # dotnet env
    $currentDotNetFile = "$dotnetBase\.current"
    # $testResult =  Test-Path $currentDotNetFile 
    # Write-Host -ForegroundColor DarkYellow "Test file result: $testResult"

    if (Test-Path $currentDotNetFile) {
        Write-Host "Found $currentDotNetFile" -ForegroundColor DarkYellow
        $version = (Get-Content -Path $currentDotNetFile -Raw).Trim()
        $env:DOTNETROOT = "$dotnetBase\$version"
        Write-Host $env:DOTNETROOT
    } else { 
        Write-Host "ERROR: Could NOT set the DOTNETROOT environment for $currentDotNetFile" -ForegroundColor Red
    }
    
    # minimal node env
    $currentNodeFile = "$nodeBase\.current"

    if (Test-Path $currentNodeFile) {
        Write-Host "Found $currentNodeFile" -ForegroundColor DarkYellow
        $version = (Get-Content -Path $currentNodeFile -Raw).Trim()
        $env:NODE_PATH = "$nodeBase\$version"
        $env:NODE_EXTRA_CA_CERTS = "$nodeBase\certs\corp-bundle.cer"
    } else {
        Write-Host "ERROR: Could NOT set the NodeJs environment for $currentNodeFile" -ForegroundColor Red
    }

    # minimal python goes here
}

Export-ModuleMember -Function Initialize-PortableEnvironment
