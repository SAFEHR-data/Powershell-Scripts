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

# VSCODE
$VSCODE_INSTALLER_FILE="VSCodeSetup-x64-latest.exe"
$VSCODE_DOWNLOAD_URL="https://code.visualstudio.com/sha/download?build=stable&os=win32-x64"
$VSCODE_INSTALL_PATH="$INSTALL_DIRECTORY\VSCode"
$VSCODE_EXTENSION_PATH="$VSCODE_INSTALL_PATH\extensions"
$VSCODE_INSTALL_ARGS="/VERYSILENT /DIR=$VSCODE_INSTALL_PATH /MERGETASKS=!runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"

[Environment]::SetEnvironmentVariable("VSCODE_EXTENSIONS", "$VSCODE_EXTENSION_PATH", [EnvironmentVariableTarget]::Machine)

Write-Log "Downloading VSCode system installer..."
Invoke-WebRequest -Uri $VSCODE_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$VSCODE_INSTALLER_FILE"

Write-Log "Installing VSCode..."
Start-Process "$BUILD_DIRECTORY\$VSCODE_INSTALLER_FILE" -ArgumentList $VSCODE_INSTALL_ARGS -Wait

Write-Log "Installing VSCode Extensions"
New-Item -Path $VSCODE_EXTENSION_PATH -ItemType Directory
# See https://code.visualstudio.com/docs/editor/command-line#_working-with-extensions
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-mssql.mssql --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-ossdata.vscode-postgresql --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-python.python --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-python.vscode-pylance --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-toolsai.vscode-ai --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-toolsai.vscode-ai-remote --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-vscode-remote.remote-containers --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-vscode-remote.remote-wsl --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-vscode.azure-repos --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-vscode.azurecli --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-vscode.PowerShell --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension ms-vscode.vscode-node-azure-pack --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension RDebugger.r-debugger --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension REditorSupport.r --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension vscodevim.vim --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension patbenatar.advanced-new-file --force" -Wait
Start-Process "$VSCODE_INSTALL_PATH\bin\code" -ArgumentList "--extensions-dir $VSCODE_EXTENSION_PATH --install-extension sleistner.vscode-fileutils --force" -Wait

Write-Log "Add VSCode to PATH environment variable"
[Environment]::SetEnvironmentVariable("PATH", "$Env:PATH;$VSCODE_INSTALL_PATH\bin", [EnvironmentVariableTarget]::Machine)

Write-Log "Add VSCode Desktop Shortcut" 
$ALL_USER_DESKTOP=[Environment]::GetFolderPath('CommonDesktopDirectory')
New-Item -ItemType SymbolicLink -Path "$ALL_USER_DESKTOP\VS Code.lnk" -Target  "$VSCODE_INSTALL_PATH\Code.exe"


Write-Log "add_vscode script completed"