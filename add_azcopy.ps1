function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"
$INSTALL_DIRECTORY="C:\Software"

$AZCOPY_INSTALLER_FILE="AzCopy.zip"
$AZCOPY_DOWNLOAD_URL="https://aka.ms/downloadazcopy-v10-windows"
$AZCOPY_INSTALL_PATH="$INSTALL_DIRECTORY\AZCopy"

Write-Log "Downloading AZCOPY installer"
Invoke-WebRequest -Uri $AZCOPY_DOWNLOAD_URL -OutFile $BUILD_DIRECTORY\$AZCOPY_INSTALLER_FILE -UseBasicParsing

Write-Log "Extract installer"
Expand-Archive $BUILD_DIRECTORY\$AZCOPY_INSTALLER_FILE $BUILD_DIRECTORY\AzCopy -Force

Write-Log "Move AzCopy"
mkdir $AZCOPY_INSTALL_PATH
Get-ChildItem $BUILD_DIRECTORY\AzCopy/*/azcopy.exe | Move-Item -Destination "$AZCOPY_INSTALL_PATH\"

Write-Log "Add AzCopy to PATH environment variable"
[Environment]::SetEnvironmentVariable("PATH", "$Env:PATH;AZCOPY_INSTALL_PATH", [EnvironmentVariableTarget]::Machine)

Write-Log "add_azcopy script completed"