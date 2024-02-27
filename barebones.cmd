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
:: STARTING NUMBERS                       
:setfile
cls
set /p filename=Please Enter an Existing File Name/ Or a New File Name:
cls
title BareBones IDE │ Coding "%filename%"
:optionbar
set number=0 
cls
echo [40;37m──────────────────┬───────────────────┬─────────────────────────────┬──────────────────────
echo Theme: Basic/Dos  │ "[40;32m/stop[40;37m" To Stop   │ "[40;32m/help[40;37m" to Access Help Menu │ Filename: %filename% 
echo ──────────────────┴───────────────────┴─────────────────────────────┴──────────────────────
title BareBones IDE │ Coding "%filename%"
:numberline
set /a "number+=1"
set "padded_number=00%number%"
set "padded_number=!padded_number:~-3!"
set /p "linecommand=[40;31m!padded_number![40;37m│%textcolor%"
if "%linecommand%" == "/stop" goto stop
if "%linecommand%" == "/testfile" start %filename% &&  goto numberline
if "%linecommand%" == "/help" goto help
if "%linecommand%" == "/swapfile" goto swapfile
if "%linecommand%" == "/swapcolor" goto swapcolor
if "%linecommand%" == "/delfile" del %filename% && goto setfile
if "%linecommand%" == "/clrfile" echo .>%filename% && goto numberline
if "%linecommand%" == "/applyupdt" goto update
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
echo STA│
goto numberline

:swapfile
echo FIN│
echo  → │ CURRENTFILE: %filename%
set /p newfile=   /  │ NEWFILE: 
echo STA│
set filename=%newfile%
goto optionbar

:swapcolor
echo FIN│
echo  → │ CURRENTCOLOR: %textcolor%
set /p txtcolor=   /  │ NEW COLOR: 
if %txtcolor%==red set textcolor =[40;31m && goto numberline
if %txtcolor%==yellow set textcolor = [40;33m && goto numberline
if %txtcolor%==green set textcolor = [40;32m && goto numberline
if %txtcolor%==blue set textcolor = [40;34m && goto numberline
if %txtcolor%==purple set textcolor = [40;35m && goto numberline
set textcolor = [40;37m && goto numberline

:update
:: - add a process -
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;31m━━━━
PING -n 1 8.8.8.8 | FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;31m━━━━━━━━
PING -n 1 8.8.8.8 | FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;31m━━━━━━━━━━━━
PING -n 1 8.8.8.8 | FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;31m━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 | FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;31m━━━━━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 | FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;33m━━━━━━━━━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 | FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 | FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 | FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PING -n 1 8.8.8.8 | FIND "TTL=">nul && cls
:: - add a process -
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;32mFinished Update Probe...
PING -n 1 8.8.8.8 | FIND "TTL=">nul && echo [40;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
timeout 3 >nul
goto optionbar

