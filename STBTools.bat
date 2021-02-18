@echo off
color 0A
mode con:cols=80 lines=24
title STB TOOLS by fr05t
IF not exist apks (mkdir apks)

goto MENU

:MENU
cls 
echo.
echo.
echo   ----------------------------------------------------------------------------
echo.
echo                                           ***      **** ****  *
echo           fr05t STB Tools                **        * ** *    ****
echo           Version 0.8B                  ****   *** * ** ***   *
echo           for B860H_V5                   *    **   ** *    *  *
echo                                          *    *    **** ***    ***
echo.
echo   ----------------------------------------------------------------------------
echo   * Sebelum menggunakan tools ini, pastikan telah menyalakan USB debugging *
echo     * pada Developer Option di Setting STB B860H_V5 dan di wifi yang sama *
echo   ----------------------------------------------------------------------------
echo.
echo                  (1). Connect STB B860H_V5 via Wifi
echo                  (2). Ganti Launcher dan disable launcher bawaan
echo                  (3). Install Aplikasi Sekaligus di Folder apks
echo.
echo                  (0). Exit
echo.
echo   ----------------------------------------------------------------------------
echo                          Pilih Menu 1, 2 atau Menu 3
echo   ----------------------------------------------------------------------------
echo.
goto OPSI

:OPSI
set/p "pilih=>"
if %pilih%==1 goto runCONNECTADB
if %pilih%==2 goto runCHANGE_LAUNCHER
if %pilih%==3 goto runINSTALL_APKS
if %pilih%==0 goto runEXIT

:runCONNECTADB
echo.
set /p "ipaddress=> Masukkan IP Address STB: "
echo Menghubungi %ipaddress%
adb kill-server
adb connect %ipaddress%
echo.
pause> nul | set /p "=>>>>>>>> Tekan sembarang tombol untuk kembali ke MENU <<<<<<<<"
goto MENU

:runCHANGE_LAUNCHER
adb install \launcher.apk
adb shell <pm disable-user --user 0 com.launcher.idn>
echo.
pause> nul | set /p "=>>>>>>>> Tekan sembarang tombol untuk kembali ke MENU <<<<<<<<"
goto MENU

:runINSTALL_APKS
echo.
setlocal enableextensions enabledelayedexpansion
set /a count = 0
echo Menyiapkan APK......
FOR /f "delims=|" %%f in ('dir /b "apks\"*.apk') do (
    echo.
    set /a count += 1
    echo !count!. Menginstall %%f :
    adb.exe install -r "apks\%%f
echo.
pause> nul | set /p "=>>>>>>>> Tekan sembarang tombol untuk kembali ke MENU <<<<<<<<"
goto MENU

:runEXIT
echo.
echo   ----------------------------------------------------------------------------
echo                                Goodbye...
echo   ----------------------------------------------------------------------------
adb disconnect
adb kill-server
echo.
pause> nul | set /p "=>>>>>>>> Tekan sembarang tombol untuk keluar <<<<<<<<"
exit