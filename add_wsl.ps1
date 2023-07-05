function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

Write-Log "Install Default WSL System"
Start-Process wsl -ArgumentList "--install" -Wait

Write-Log "add_wsl script completed"