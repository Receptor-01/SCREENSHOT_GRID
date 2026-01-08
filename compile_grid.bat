@echo off
setlocal EnableDelayedExpansion

cls
echo ===================================================
echo                SCREENSHOT COMPILER
echo ===================================================
echo ---------------------------------------------------
echo.

REM ================= CONFIG ===========================
set MAGICK=tools\magick.exe
set MONTAGE=tools\montage.exe
set INPUT=input
set OUTPUT=output
REM ====================================================

REM ------------- PROMPT FOR OUTPUT FILE NAME ----------
set /p FILENAME=FILE NAME: 

if "%FILENAME%"=="" (
    echo ERROR: File name cannot be empty
    pause
    exit /b
)

set FINAL_IMAGE=%OUTPUT%\%FILENAME%.png
set BODY_IMAGE=%OUTPUT%\body.png
set HEADER_IMAGE=%OUTPUT%\header.png

REM ------------- PROMPT FOR TITLE ---------------------

set /p TITLE=TITLE: 

if "%TITLE%"=="" (
    echo ERROR: Title cannot be empty
    pause
    exit /b
)

REM ------------- PROMPT FOR LAYOUT --------------------
echo SELECT LAYOUT: [G] = Grid, [V] = Vertial
set /p LAYOUT=ENTER: 

if /I not "%LAYOUT%"=="G" if /I not "%LAYOUT%"=="V" (
    echo ERROR: Invalid choice
    pause
    exit /b
)
if /I "%LAYOUT%"=="G" set LAYOUT_NAME=Grid
if /I "%LAYOUT%"=="V" set LAYOUT_NAME=Vertical

REM ------------- SANITY CHECKS ------------------------
echo.
timeout /t 1 >nul
echo _
timeout /t 1 >nul
echo __
timeout /t 1 >nul
echo ___

if not exist "%MAGICK%" (
    echo ERROR: magick.exe not found
    pause
    exit /b
)

if not exist "%INPUT%" (
    echo ERROR: input folder missing
    pause
    exit /b
)

if not exist "%OUTPUT%" (
    mkdir "%OUTPUT%"
)


REM ------------- CREATE BODY IMAGE --------------------

if /I "%LAYOUT%"=="G" (
    "%MONTAGE%" "%INPUT%\*.png" -resize 1200x1200 -background black -gravity center -extent 1200x1200 -tile 3x -geometry +20+20 -strip "%BODY_IMAGE%"
)

if /I "%LAYOUT%"=="V" (
    "%MAGICK%" "%INPUT%\*.png" -append -strip "%BODY_IMAGE%"
)


REM ------------- DETECT BODY WIDTH --------------------

for /f "usebackq delims=" %%W in (`
    cmd /c ""%MAGICK%" identify -quiet -format %%w "%BODY_IMAGE%""
`) do set BODY_WIDTH=%%W

if not defined BODY_WIDTH (
    echo WARNING: Width detection failed. Using fallback width 1200.
    set BODY_WIDTH=1200
)


REM ------------- CREATE HEADER -------------------------

REM -- GRID: single-line title

if /I "%LAYOUT%"=="G" (
    "%MAGICK%" -size !BODY_WIDTH!x400 xc:black ^
    -fill white ^
    -gravity center ^
    -pointsize 64 ^
    -annotate +0+0 "!TITLE!" ^
    "%HEADER_IMAGE%"
)

REM -- VERTICAL: wrapped title
if /I "%LAYOUT%"=="V" (
    "%MAGICK%" -size !BODY_WIDTH!x500 ^
    -background black ^
    -fill white ^
    -gravity center ^
    -pointsize 56 ^
    caption:"!TITLE!" ^
    "%HEADER_IMAGE%"
)

REM ------------- COMBINE HEADER + BODY ----------------

"%MAGICK%" "%HEADER_IMAGE%" "%BODY_IMAGE%" -append "%FINAL_IMAGE%"

REM ------------- CLEANUP ------------------------------
del "%HEADER_IMAGE%"
del "%BODY_IMAGE%"

echo.
echo -------------------------
echo  OUTPUT:  %FINAL_IMAGE%
echo -------------------------
pause

