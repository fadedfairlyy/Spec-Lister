# Get CPU information
$CPU = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name

# Get GPU information
$GPU = Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name

# Get RAM size in GB
$RAM = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB, 2)

# Get screen resolution
$Screen = Get-CimInstance Win32_VideoController
$ResolutionWidth = $Screen.CurrentHorizontalResolution
$ResolutionHeight = $Screen.CurrentVerticalResolution

# Check if it's a Laptop or PC
$ChassisType = (Get-CimInstance Win32_SystemEnclosure).ChassisTypes
if ($ChassisType -match "8|9|10|11|14|18|21") {
    $DeviceType = "Laptop"
} else {
    $DeviceType = "PC"
}

# Display information
Write-Host "CPU: $CPU"
Write-Host "GPU: $GPU"
Write-Host "RAM: $RAM GB"
Write-Host "Screen Resolution: $ResolutionWidth x $ResolutionHeight"
Write-Host "Device Type: $DeviceType"

# Keep the window open
Read-Host "Press Enter to exit"
