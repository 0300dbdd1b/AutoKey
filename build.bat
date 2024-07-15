@echo off
setlocal

rem Project name and directories
set NAME=AutoKey
set SRCDIR=src
set INCDIR=include
set OBJDIR=obj
set BINDIR=bin
set LIBDIR=lib

set AKSCRIPTDIR=%SRCDIR%\AKScript
set WINDOWSDIR=%AKSCRIPTDIR%\Windows

rem Include directories
set INCLUDE_DIRS=%INCDIR% %INCDIR%\AKScript
set INCLUDE_FLAGS=
for %%I in (%INCLUDE_DIRS%) do set INCLUDE_FLAGS=!INCLUDE_FLAGS! -I%%I

rem Source files
set SRCS=%SRCDIR%\main.c ^
    %WINDOWSDIR%\WinFunctions.c

rem Replace SRCDIR with OBJDIR and .c with .o for object files
set OBJS=
for %%F in (%SRCS%) do (
    set OBJ=%%F
    set OBJ=!OBJ:%SRCDIR%=!
    set OBJ=!OBJ:.c=.o!
    set OBJS=!OBJS! %OBJDIR%!OBJ!
)

set EXEC=%BINDIR%\%NAME%.exe
set CC=gcc
set CFLAGS=-Wall -Wextra !INCLUDE_FLAGS!

rem Check if we are on Windows
if "%OS%"=="Windows_NT" (
    rem Create necessary directories
    if not exist %OBJDIR% mkdir %OBJDIR%
    if not exist %BINDIR% mkdir %BINDIR%

    rem Compile the source files
    for %%F in (%SRCS%) do (
        %CC% %CFLAGS% -c %%F -o %OBJDIR%\%%~nF.o
    )

    rem Link the object files into an executable
    %CC% %OBJS% -o %EXEC%
    echo Build completed for %NAME%
) else (
    echo This script is only for Windows.
    exit /b 1
)

goto :eof

:clean
if exist %OBJDIR% rmdir /s /q %OBJDIR%
if exist %BINDIR% rmdir /s /q %BINDIR%
goto :eof

endlocal

