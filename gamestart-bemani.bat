::
:: gamestart-bemani.bat
::
:: Configurable batch script to launch Bemani games via Bemanitools or SpiceTools
::
:: Version: 1.0.0
::
@echo off


:SET_ENVIRONMENT
echo Changing directory to '%CONTENT_ROOT%'...
pushd %CONTENT_ROOT%

set PROP_DIR=prop
set CONF_DIR=dev
set NVRAM_DIR=%CONF_DIR%\nvram
set RAW_DIR=%CONF_DIR%\raw


:CREATE_NVRAM_DIR
if exist %NVRAM_DIR% (
    echo NVRAM directory already exists.
    goto :CREATE_RAW_DIR
)
echo Creating NVRAM directory at '%CONTENT_ROOT%%NVRAM_DIR%'...
mkdir %CONF_DIR%
mkdir %NVRAM_DIR%


:CREATE_RAW_DIR
if exist %RAW_DIR% (
    echo RAW directory already exists.
    goto :COPY_DEFAULTS
)
echo Creating RAW directory at '%CONTENT_ROOT%%RAW_DIR%'...
mkdir %CONF_DIR%
mkdir %RAW_DIR%


:COPY_DEFAULTS
set DEFAULTS_DIR=%PROP_DIR%\defaults
echo Copying defaults from '%CONTENT_ROOT%%DEFAULTS_DIR%' to NVRAM directory...
if not exist %RAW_DIR%\log mkdir %RAW_DIR%\log
if not exist %RAW_DIR%\fscache mkdir %RAW_DIR%\fscache

for /R %PROP_DIR%\defaults %%D in (*.*) do (
    if not exist %NVRAM_DIR%\%%~nxD copy /y %PROP_DIR%\defaults\%%~nxD %NVRAM_DIR%\
)


:ROTATE_SCREEN
if not defined ROTATE_SCREEN_DEGREES goto :PRE_LAUNCH
if not defined KONAMI_ROOT goto :ERROR__KONAMI_ROOT
if not exist %KONAMI_ROOT% goto :ERROR__KONAMI_ROOT

set ROTATE_EXE=%KONAMI_ROOT%\rotate.exe
if not exist %ROTATE_EXE% goto :ERROR__ROTATE_EXE

echo Rotating screen to %ROTATE_SCREEN_DEGREES% degrees...
%ROTATE_EXE% -p %ROTATE_SCREEN_DEGREES%


:PRE_LAUNCH
if not defined MODULES_ROOT goto :ERROR__MODULES_ROOT
if not exist %MODULES_ROOT% goto :ERROR__MODULES_ROOT

if not defined GAME_LIBRARY_NAME goto :ERROR__GAME_LIBRARY
set GAME_LIBRARY=%MODULES_ROOT%\%GAME_LIBRARY_NAME%
if not exist %GAME_LIBRARY% goto :ERROR__GAME_LIBRARY

if "%LAUNCHER_NAME%"=="BEMANITOOLS" goto :LAUNCH_BEMANITOOLS
if "%LAUNCHER_NAME%"=="SPICETOOLS" goto :LAUNCH_SPICETOOLS
goto :ERROR__LAUNCHER_NAME


:LAUNCH_BEMANITOOLS
if not defined BEMANITOOLS_VERSION (
    set BEMANITOOLS_VERSION=5
    echo %%BEMANITOOLS_VERSION%% not set. Setting Bemanitools version to '%BEMANITOOLS_VERSION%'...
)

if not defined BEMANITOOLS_EXE goto :ERROR__BEMANITOOLS_EXE
if not exist %BEMANITOOLS_EXE% goto :ERROR__BEMANITOOLS_EXE

rem Bemanitools 4 doesn't support any flags
if %BEMANITOOLS_VERSION% geq 5 (
    if defined CONFIG_PATH_APP set CONFIG_APP_ARG=-A %CONFIG_PATH_APP%
    if defined CONFIG_PATH_AVS set CONFIG_AVS_ARG=-V %CONFIG_PATH_AVS%
    if defined CONFIG_PATH_EA3 set CONFIG_EA3_ARG=-E %CONFIG_PATH_EA3%
    if defined HEAP_SIZE (
        set HEAP_SIZE_AVS_ARG=-H %HEAP_SIZE%
        set HEAP_SIZE_STD_ARG=-T %HEAP_SIZE%
    )
)

echo Launching game via '%BEMANITOOLS_EXE%'...
%BEMANITOOLS_EXE% %CONFIG_APP_ARG% %CONFIG_AVS_ARG% %CONFIG_EA3_ARG% %HEAP_SIZE_AVS_ARG% %HEAP_SIZE_STD_ARG% %GAME_LIBRARY_NAME%
call :EXIT_AND_RETURN 0


:LAUNCH_SPICETOOLS
if not exist %SPICETOOLS_EXE% goto :ERROR__SPICETOOLS_EXE

if defined CONFIG_PATH_APP set CONFIG_APP_ARG=-A %CONFIG_PATH_APP%
if defined CONFIG_PATH_AVS set CONFIG_AVS_ARG=-V %CONFIG_PATH_AVS%
if defined CONFIG_PATH_EA3 set CONFIG_EA3_ARG=-E %CONFIG_PATH_EA3%
if defined EAMUSEMENT_URL set EAMUSEMENT_URL_ARG=-url %EAMUSEMENT_URL%
if defined EMULATE_EAMUSEMENT set EMULATE_EAMUSEMENT_ARG=-ea
if defined HEAP_SIZE set HEAP_SIZE_ARG=-h %HEAP_SIZE%

echo Launching game via '%SPICETOOLS_EXE%'...
%SPICETOOLS_EXE% %CONFIG_APP_ARG% %CONFIG_AVS_ARG% %CONFIG_EA3_ARG% %EAMUSEMENT_URL_ARG% %EMULATE_EAMUSEMENT_ARG% %HEAP_SIZE_ARG% -modules %MODULES_ROOT% %GAME_LIBRARY_NAME%
call :EXIT_AND_RETURN 0


:ERROR__KONAMI_ROOT
echo ERROR: Unable to find Konami root directory at '%KONAMI_ROOT%'!
call :EXIT_AND_RETURN -1


:ERROR__ROTATE_EXE
echo ERROR: Unable to find Konami rotate executable at '%ROTATE_EXE%'!
call :EXIT_AND_RETURN -2


:ERROR__MODULES_ROOT
echo ERROR: Unable to find game modules directory at '%MODULES_ROOT%'!
call :EXIT_AND_RETURN -3


:ERROR__GAME_LIBRARY
echo ERROR: Unable to find Game DLL at '%GAME_LIBRARY%'!
call :EXIT_AND_RETURN -4


:ERROR__LAUNCHER_NAME
echo ERROR: Invalid launcher name '%LAUNCHER_NAME%' was given!
echo Valid launcher names are 'BEMANITOOLS' or 'SPICETOOLS'.
call :EXIT_AND_RETURN -5


:ERROR__BEMANITOOLS_EXE
echo ERROR: Unable to find Bemanitools executable at '%BEMANITOOLS_EXE%'!
call :EXIT_AND_RETURN -6


:ERROR__SPICETOOLS_EXE
echo ERROR: Unable to find Spice executable at '%SPICETOOLS_EXE%'!
call :EXIT_AND_RETURN -7


:EXIT_AND_RETURN
if defined PAUSE_ON_EXIT pause
popd
exit %1
