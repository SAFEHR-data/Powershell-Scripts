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

# R
$R_INSTALLER_FILE="R-4.3.1-win.exe"
$R_MIRROR="cran.ma.imperial.ac.uk"
$R_DOWNLOAD_URL="https://$R_MIRROR/bin/windows/base/$R_INSTALLER_FILE"
$R_INSTALL_PATH="$INSTALL_DIRECTORY\R"
$R_INSTALL_ARGS="/VERYSILENT /NORESTART /ALLUSERS /DIR=$R_INSTALL_PATH"

Write-Log "Downloading R-Base Package installer..."
Invoke-WebRequest -Uri $R_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$R_INSTALLER_FILE"

Write-Log "Installing R-Base Package..."
Start-Process $R_INSTALLER_FILE -ArgumentList $R_INSTALL_ARGS -Wait

Write-Log "Adding R installation information to windows registry..."
Start-Process "$R_INSTALL_PATH\bin\x64\RSetReg.exe" -Wait

# RTools - This need to be install at the default location to avoid rtools not found errors.
$RTools_INSTALLER_FILE="rtools42-5355-5357.exe"
$RTools_DOWNLOAD_URL="https://cran.r-project.org/bin/windows/Rtools/rtools42/files/$RTools_INSTALLER_FILE"
$RTools_INSTALL_ARGS="/VERYSILENT /NORESTART /ALLUSERS"

Write-Log "Downloading RTools installer..."
Invoke-WebRequest -Uri $RTools_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$RTools_INSTALLER_FILE"

Write-Log "Installing RTools..."
Start-Process $RTools_INSTALLER_FILE -ArgumentList $RTools_INSTALL_ARGS -Wait

# RStudio
$RStudio_INSTALLER_FILE="RStudio-2023.06.0-421.exe"
$RStudio_DOWNLOAD_URL="https://download1.rstudio.org/desktop/windows/$RStudio_INSTALLER_FILE"
$RStudio_INSTALL_PATH="$INSTALL_DIRECTORY\RStudio"
$RStudio_INSTALL_ARGS="/S /D=$RStudio_INSTALL_PATH"

Write-Log "Downloading RStudio Package installer..."
Invoke-WebRequest -Uri $RStudio_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$RStudio_INSTALLER_FILE"

Write-Log "Installing RStudio Package..."
Start-Process $RStudio_INSTALLER_FILE -ArgumentList $RStudio_INSTALL_ARGS -Wait

# PATH
Write-Log "Add R to PATH environment variable"
[Environment]::SetEnvironmentVariable("PATH", "$Env:PATH;$R_INSTALL_PATH\bin", [EnvironmentVariableTarget]::Machine)

# R packages and tinytex for Rmd rendering

Write-Log "Installing common R packages..."
R.exe -e "install.packages(c('tidyverse', 'rmarkdown', 'tinytex'), repos='$R_MIRROR')"
R.exe -e "tinytex::install_tinytex()"

Write-Log "add_r_toolset script completed"
