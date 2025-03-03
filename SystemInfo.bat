@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "& { 
    try {
        $CPU = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name;
        $GPU = Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name;
        $RAM = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB, 2);
        $ChassisType = (Get-CimInstance Win32_SystemEnclosure).ChassisTypes;
        if ($ChassisType -match '8|9|10|11|14|18|21') { $DeviceType = 'Laptop'; } else { $DeviceType = 'PC'; }
        Write-Host 'CPU: ' $CPU;
        Write-Host 'GPU: ' $GPU;
        Write-Host 'RAM: ' $RAM 'GB';
        Write-Host 'Device Type: ' $DeviceType;
    } catch {
        Write-Host "An error occurred: $_"
    }
    Read-Host 'Press Enter to exit'
}"
pause
