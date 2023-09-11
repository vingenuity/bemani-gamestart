@echo off


:set_environment
rem Path to the Bemani gamestart batch file to call to start the game.
rem Call gamestart-logger.bat if you would like a log file containing the output of this script.
rem Call gamestart-bemani.bat if you do not want any log files.
set BEMANI_GAMESTART_BATCH=gamestart-logger.bat

rem Path to the Bemanitools launcher executable.
rem This path can be relative to the content root or absolute.
rem This path is only used if the launcher name is 'BEMANITOOLS'.
set BEMANITOOLS_EXE=launcher.exe

rem Version of Bemanitools being used to launch the game.
rem Bemanitools 4 does not support command-line flags, so any flag options will be ignored.
set BEMANITOOLS_VERSION=5

rem Path to the app configuration XML for the game.
rem For both Bemanitools and SpiceTools, this shouldn't be necessary unless the XML is in an unusual location.
rem set CONFIG_PATH_APP=prop\app-config.xml

rem Path to the AVS configuration XML for the game.
rem For both Bemanitools and SpiceTools, this shouldn't be necessary unless the XML is in an unusual location.
rem set CONFIG_PATH_AVS=prop\avs-config.xml

rem Path to the ea3 (e-amusement) configuration XML for the game.
rem For both Bemanitools and SpiceTools, this shouldn't be necessary unless the XML is in an unusual location.
rem set CONFIG_PATH_EA3=prop\ea3-config.xml

rem Path to the content root directory for the game being launched.
rem Generally, this batch file should be placed in the game's 'content/' subfolder, and thus '%~dp0' is a good default.
rem If you would like to place these scripts elsewhere, change this value.
set CONTENT_ROOT=%~dp0

rem Optional URL to use for e-amusement service.
rem This argument is only used if the launcher name is 'SPICETOOLS'.
rem set EAMUSEMENT_URL=localhost:8083

rem If set, e-amusement services will be emulated by the tools.
rem When this option is used, the game will believe that its e-amusement services are down for maintenance.
rem This argument is only used if the launcher name is 'SPICETOOLS'.
rem set EMULATE_EAMUSEMENT=True

rem The name of the dynamically-linked library (DLL) that will be used to launch the game.
rem THIS IS NOT A PATH! This DLL is assumed to be relative to MODULES_ROOT.
set GAME_LIBRARY_NAME=bemanigame.dll

rem Optional argument to define the size of the heap memory used by the game.
set HEAP_SIZE=26214400

rem Path to the Konami directory, where Konami's tool executables are located.
rem This directory is typically 'C:\konami'.
set KONAMI_ROOT=C:\konami

rem Launcher program to use to launch the game.
rem Can be either 'BEMANITOOLS' or 'SPICETOOLS'.
set LAUNCHER_NAME=BEMANITOOLS

rem Path to the modules root for the game being launched.
rem This path can be relative to the content root or absolute.
rem Generally, this value should be either '%CONTENT_ROOT%' or 'modules'.
set MODULES_ROOT=%CONTENT_ROOT%

rem Comment out this setting if you would like the command prompt window to close after launching the game.
rem Set it to true to leave the window open to help debug script issues.
rem set PAUSE_ON_EXIT=True

rem If set, Konami's rotate executable will be used to rotate the screen to this orientation.
rem Valid rotation values are 0, 90, 180, 270.
rem set ROTATE_SCREEN_DEGREES=

rem Path to the main SpiceTools executable.
rem This path can be relative to the content root or absolute.
rem This path is only used if the launcher name is 'SPICETOOLS'.
set SPICETOOLS_EXE=spice.exe


:main
call %BEMANI_GAMESTART_BATCH% %*
