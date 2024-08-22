@echo off
title PC Troubleshooter

:menu
cls
echo.
echo ============================================
echo PC Troubleshooter Menu (Admin maybe Required)      
echo ============================================
echo 1. Check PC Status
echo 2. Fix Network Issues
echo 3. Clean Temp Files
echo 4. Check Disk for Issues
echo 5. Scan System Files
echo 6. Reset Winsock
echo 7. Clear DNS Cache
echo 8. Check for Windows updates
echo 9. Check System Usage
echo 10. Exit
echo.
set /p choice="Select an option (1-10): "

rem Redirect to the appropriate section based on user choice
if "%choice%"=="1" goto :check_status
if "%choice%"=="2" goto :fix_network
if "%choice%"=="3" goto :clean_temp
if "%choice%"=="4" goto :check_disk
if "%choice%"=="5" goto :scan_sfc
if "%choice%"=="6" goto :reset_winsock
if "%choice%"=="7" goto :clear_dns
if "%choice%"=="8" goto :check_updates
if "%choice%"=="9" goto :check_resources
if "%choice%"=="10" goto :exit
echo Not an option from the list, Try again
pause
goto :menu

:check_status
echo.
echo Checking PC status...
echo Uptime:
systeminfo | find "System Boot Time"
echo Disk Space
echo.
wmic logicaldisk get size,freespace,caption
echo Memory Usage
echo.
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value
pause
goto :menu

:fix_network
echo.
echo Fixing network any issues
ipconfig /release
ipconfig /renew
ipconfig /flushdns
echo Network issues should be fixed if not then you may need to look into it
pause
goto :menu

:clean_temp
echo.
echo Cleaning temp files
del /q /f /s %TEMP%\*
rd /s /q %TEMP%
echo Temporary files cleaned.
pause
goto :menu

:check_disk
echo.
echo Checking disk for issues
chkdsk C: /f
echo Disk check complete.
pause
goto :menu

:scan_sfc
echo.
echo Scanning system files for corruption or issues
sfc /scannow
echo System file scan complete.
pause
goto :menu

:reset_winsock
echo.
echo Resetting Winsock This may take some time
netsh winsock reset
echo Winsock reset complete.
pause
goto :menu

:clear_dns
echo.
echo Clearing DNS cache...
ipconfig /flushdns
echo DNS cache cleared.
pause
goto :menu

:check_updates
echo.
echo Checking for Windows updates
powershell -command "Get-WindowsUpdateLog"
echo Windows update check complete.
pause
goto :menu

:check_resources
echo.
echo Checking system resource usage...
echo CPU Usage
wmic cpu get loadpercentage
echo Memory Usage
systeminfo | find "Available Physical Memory"
pause
goto :menu

:exit
exit
