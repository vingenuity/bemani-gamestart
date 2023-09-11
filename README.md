# bemani-gamestart
Configurable batch script to launch Bemani games via Bemanitools or SpiceTools

## Usage
1. Mount a hard drive containing Bemani game data.
2. Locate the partition containing the game data (usually `D:` or `E:`).
3. Copy "gamestart-bemani.bat", "unxutils-tee.exe", and (optionally) "gamestart-logger.bat" to the root of the game partition.
4. Copy either Bemanitools or SpiceTools somewhere on the game partition.
5. Copy "gamestart-example.bat" to the content directory of the game data (usually `GAME-CODE\contents`).
6. Edit "gamestart-example.bat" to suit your game data. The most important settings are:
    - `BEMANITOOLS_EXE/SPICETOOLS_EXE` to your launcher executable of choice.
    - `GAME_LIBRARY_NAME` to the library for the Bemani game (e.g. `bemanigame.dll`).
    - `LAUNCHER_NAME` to the name of the launcher being used (`BEMANITOOLS/SPICETOOLS`).
    - `MODULES_ROOT` to the location of the Bemani game modules (i.e. the ".dll" files).
7. Update the Bemani launching batch files (or your Bemani menu of choice) to launch "gamestart-example.bat".
