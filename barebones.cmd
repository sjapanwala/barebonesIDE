@echo off
chcp 65001
title BareBones IDE │ %username%
setlocal enabledelayedexpansion
cls
:: TEXT COLOR
::RED  [40;31m
::YELLOW  [40;33m
::GREEM  [40;32m
::BLUE  [40;34m
::PURPLE  [40;35m
::WHITE  [40;37m
set textcolor=[40;37m
set textcolorread=White
set columnclr=[40;31m
set colomnclrread=Red
set codetag=False
if exist codetag.txt set codetag=True
:: STARTING NUMBERS      
set "filenumber=1"
:setfile
cls
::ui
:: Initialize count and collect project names
set count=0
for /f %%a in ('dir /b') do (
    set /a count+=1
    set "projectname[!count!]=%%a"
)

:: UI section
cls
echo. 
echo                                     _                    _                           
echo                                    │ │__   __ _ _ __ ___│ │__   ___  _ __   ___  ___ 
echo                                    │ '_ \ / _` │ '__/ _ \ '_ \ / _ \│ '_ \ / _ \/ __│
echo                                    │ │_) │ (_│ │ │ │  __/ │_) │ (_) │ │ │ │  __/\__ \
echo                                    │_.__/ \__,_│_│  \___│_.__/ \___/│_│ │_│\___││___/
echo.                                                    
echo. 
echo.
echo                                                  Previous Projects
echo                             ┌────────────────────────────────────────────────────────────┐
for /l %%i in (1, 1, %count%) do (
                                       echo                               - !projectname[%%i]!
)
echo                              └────────────────────────────────────────────────────────────┘                                                                                                  
set /p "filename=.                            Please Enter a New/Existing FileName: "
if not defined filename goto namefile
goto cont
:namefile
if not exist "untitledfile_!filenumber!.txt" (
    set "filename=untitledfile_!filenumber!.txt"
) else (
    set /a "filenumber+=1"
    goto namefile
)
:cont
cls
title BareBones IDE │ Coding "%filename%"
:optionbar
set number=0 
cls
echo [40;37m──────────────────┬───────────────────┬─────────────────────────────┬────────────────────────────────
echo Theme: Basic/Dos  │ "[40;32m/stop[40;37m" To Stop   │ "[40;32m/help[40;37m" to Access Help Menu │ Filename: %filename% 
echo ──────────────────┴───────────────────┴─────────────────────────────┴────────────────────────────────
title BareBones IDE │ Coding "%filename%"
:numberline
set previousline=%linecommand%
set /a "number+=1"
set "padded_number=00%number%"
set "padded_number=!padded_number:~-3!"
set /p "linecommand=%columnclr%!padded_number![40;37m│%textcolor%"
if "%linecommand%" == "/stop" goto stop
if "%linecommand%" == "/testfile" start %filename% &&  goto numberline
if "%linecommand%" == "/help" goto help
if "%linecommand%" == "/swapfile" goto swapfile
if "%linecommand%" == "/swapcolor" goto swapcolor
if "%linecommand%" == "/delfile" del %filename% && goto setfile
if "%linecommand%" == "/clrfile" echo .>%filename% && goto numberline
if "%linecommand%" == "/applyupdt" goto update
if "%linecommand%" == "/dellast" goto dellast
if "%linecommand%" == "/d" goto dellast
if "%linecommand%" == "/t" start %filename% &&  goto numberline
if "%linecommand%" == "/settings" goto settings
if "%linecommand%" == "/root" goto root
if "%linecommand%" == "-#" set linecommand=#---LINEBREAK---#
echo %linecommand%>>%filename%
goto numberline
:stop
echo FIN│
echo  → │    CODE ENDED
echo  → │ PRESS ENTER TO EXIT
pause>nul
exit

:help
echo FIN│
echo  → │ --SHORTCUTS + COMMANDS--
echo  → │ Enter "/stop"       to end file
echo  → │ Enter "/help"       to bring up this menu
echo  → │ Enter "/testfile"   to test the current file
echo  → │ Enter "/swapfile"   to change current file
echo  → │ Enter "/swapcolor"  to change the color of the IDE
echo  → │ Enter "/clrfile"    to clear the file data
echo  → │ Enter "/delfile"    to delete current file
echo  → │ Enter "/applyupdt"  to probe and apply updates
echo  → │ Enter "-{cmntchar}" to add a break in the line as a comment
echo  → │ Enter "/dellast"    to remove the last line (ca   n be recursed)
echo  → │ Enter "/settings"   to change settings
echo  → │ Enter "/root"       to plant this file into user/username (to access from terminal)
echo  → │ --QUICK SHORTCUTS --
echo  → │ Enter "/d" to delete last
echo  → │ Enter "/t" to test file
echo STA│
goto numberline

:swapfile
goto setfile
echo FIN│
echo  → │ CURRENTFILE: %filename%
set /p newfile=   /  │ NEWFILE: 
echo STA│
set filename=%newfile%
goto optionbar

:swapcolor
echo FIN│
echo  → │ CURRENTCOLOR: %textcolorread%
set /p txtcolor=   /  │ NEW COLOR: 
if %txtcolor%==red set textcolor =[40;31m && goto numberline
if %txtcolor%==yellow set textcolor =[40;33m && goto numberline
if %txtcolor%==green set textcolor =[40;32m && goto numberline
if %txtcolor%==blue set textcolor =[40;34m && goto numberline
if %txtcolor%==purple set textcolor =[40;35m && goto numberline
set textcolor = [40;37m && goto numberline

:dellast
rem Check if the file exists
if not exist "%filename%" (
    echo File "%filename%" does not exist.
    exit /b
)

rem Read the file line by line and store them in an array
set "count=0"
for /f "delims=" %%a in (%filename%) do (
    set /a count+=1
    set "line[!count!]=%%a"
)

rem Overwrite the original file with the lines except the last one
(for /l %%i in (1,1,%count%) do (
    if %%i neq %count% echo !line[%%i]!
)) > "%filename%.temp"

rem Replace the original file with the modified one
move /y "%filename%.temp" "%filename%" > nul
echo Removed "%previousline%"
goto numberline

:settings
echo [40;37mFIN│
echo  → │ - VISUAL SETTINGS
echo  → │ LineColor :----: %textcolor%[][40;37m
echo  → │ ColumnColor :--: %columnclr%[][40;37m
echo  → │ - DATA SETTINGS
echo  → │ CodeTag :------: %codetag%
echo STA│
goto numberline

:root
move barebones.cmd C:\users\%username%

:update
:: - add a process -
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;31m━━━━
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;31m━━━━━━━━
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;31m━━━━━━━━━━━━
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;31m━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;31m━━━━━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;33m━━━━━━━━━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;32mFinished Update Probe...
PING -n 1 8.8.8.8 │ FIND "TTL=">nul && echo [40;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
timeout 3 >nul
goto optionbar

