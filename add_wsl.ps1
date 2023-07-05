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

# When running `wsl --install` in packer, the output looks like WSL1 was already installed
# carrying out manual update steps https://learn.microsoft.com/en-gb/windows/wsl/install-manual 
Write-Log "Running steps for conversion of wsl1 to wsl2..."
$WSL_UPDATE_URL="https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$WSL_UPDATE_FILE="wsl_update.msi"
Start-Process Dism.exe -ArgumentList "/online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart" -Wait
Start-Process Dism.exe -ArgumentList "/online /enable-feature /featurename:VirtualMachinePlatform /all /norestart" -Wait

Write-Log "Downloading WSL updater..."
Invoke-WebRequest -Uri $WSL_UPDATE_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$WSL_UPDATE_FILE"

Write-Log "Running WSL updater..."
Start-Process msiexec.exe -ArgumentList "/I $WSL_UPDATE_FILE ALLUSERS='1' /quiet /norestart" -Wait

Write-Log "add_wsl script completed"