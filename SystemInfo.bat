@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "& { 
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
    if ($ChassisType -match '8|9|10|11|14|18|21') { 
        $DeviceType = 'Laptop' 
    } else { 
        $DeviceType = 'PC' 
    }

    # Get Storage type and size (SSD or HDD)
    $Disk = Get-CimInstance Win32_DiskDrive | Select-Object Model, MediaType, @{Name='SizeGB';Expression={[math]::round($_.Size / 1GB)}}

    # Display information
    Write-Host 'CPU: ' $CPU
    Write-Host 'GPU: ' $GPU
    Write-Host 'RAM: ' $RAM 'GB'
    Write-Host 'Screen Resolution: ' $ResolutionWidth 'x' $ResolutionHeight
    Write-Host 'Device Type: ' $DeviceType

    # Display Disk Information (SSD/HDD and Size)
    foreach ($d in $Disk) {
        Write-Host 'Disk Type: ' $($d.MediaType)
        Write-Host 'Disk Size: ' $($d.SizeGB) 'GB'
    }

    Read-Host 'Press Enter to exit'
}"
pause
