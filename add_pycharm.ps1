function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"
$INSTALL_DIRECTORY="C:\Software"

Set-Location -Path $BUILD_DIRECTORY

# PyCharm
$PYCHARM_VERSION="2024.2.3"
$PYCHARM_DOWNLOAD_URL="https://download.jetbrains.com/python/pycharm-community-${PYCHARM_VERSION}.exe"
$PYCHARM_INSTALLER_FILE="pycharm_installer.exe"
$PYCHARM_LOG_FILE="pycharm_install.log"
$PYCHARM_INSTALL_PATH="$INSTALL_DIRECTORY\PyCharm"

Write-Log "Downloading PyCharm installer..."
Invoke-WebRequest -Uri $PYCHARM_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$PYCHARM_INSTALLER_FILE"

# silent installation https://www.jetbrains.com/help/pycharm/installation-guide.html#silent
$PYCHARM_INSTALL_ARGS="/S /LOG=$PYCHARM_LOG_FILE /D=$PYCHARM_INSTALL_PATH"
Write-Log "Running PyCharm installer..."
Start-Process $PYCHARM_INSTALLER_FILE -ArgumentList $PYCHARM_INSTALL_ARGS -Wait

Write-Log "Add PyCharm to PATH environment variable"
[Environment]::SetEnvironmentVariable("PATH", "$Env:PATH;$PYCHARM_INSTALL_PATH\bin", [EnvironmentVariableTarget]::Machine)

Write-Log "Add Pycharm Desktop Shortcut"
$ALL_USER_DESKTOP=[Environment]::GetFolderPath('CommonDesktopDirectory')
New-Item -ItemType SymbolicLink -Path "$ALL_USER_DESKTOP\PyCharm.lnk" -Target  "$PYCHARM_INSTALL_PATH\bin\pycharm64.exe"

Write-Log "add_pycharm script completed"