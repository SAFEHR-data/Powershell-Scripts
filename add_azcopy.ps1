function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"
$INSTALL_DIRECTORY="C:\Software"

$AZCOPY_INSTALLER_FILE="MicrosoftAzureStorageAzCopy_netcore_x64.msi"
$AZCOPY_DOWNLOAD_URL="https://aka.ms/downloadazcopy"
$AZCOPY_INSTALL_ARGS="/qn /jm"

Write-Log "Downloading AZCOPY installer"
Invoke-WebRequest $AZCOPY_DOWNLOAD_URL -OutFile $BUILD_DIRECTORY\$AZCOPY_INSTALLER_FILE

Write-Log "Installing AZCOPY"
Start-Process -FilePath "$BUILD_DIRECTORY\$AZCOPY_INSTALLER_FILE" -ArgumentList "/qn /norestart" -Wait
