function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"
$INSTALL_DIRECTORY="C:\Software"

# Git Bash
$GitBash_INSTALLER_FILE="Git-2.40.0-64-bit.exe"
$GitBash_SETTINGS_FILE=
$GitBash_DOWNLOAD_URL="https://github.com/git-for-windows/git/releases/download/v2.40.0.windows.1/$GitBash_INSTALLER_FILE"
$GitBash_INSTALL_ARGS="/NORESTART /VERYSILENT /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /LOG=$BUILD_DIRECTORY\git-for-windows.log /LOADINF=$BUILD_DIRECTORY\add_bash.inf /SUPPRESSMSGBOXES /ALLUSERS"

Write-Log "Downloading Git Bash"
Invoke-WebRequest -Uri $GitBash_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$GitBash_INSTALLER_FILE"

Write-Log "Installing Git Bash"
Start-Process "$BUILD_DIRECTORY\$GitBash_INSTALLER_FILE" -ArgumentList $GitBash_INSTALL_ARGS -Wait

Write-Log "rpython_init script complete."