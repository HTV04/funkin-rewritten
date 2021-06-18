# ![Logo](images/logo.png)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/HTV04/funkin-rewritten?style=flat-square) ![GitHub all releases](https://img.shields.io/github/downloads/HTV04/funkin-rewritten/total?style=flat-square) ![GitHub issues](https://img.shields.io/github/issues/HTV04/funkin-rewritten?style=flat-square) ![GitHub](https://img.shields.io/github/license/HTV04/funkin-rewritten?style=flat-square) ![Discord](https://img.shields.io/discord/852658576577003550?style=flat-square)

*Friday Night Funkin' Rewritten* is a rewrite of [*Friday Night Funkin'*](https://ninja-muffin24.itch.io/funkin) using [LÖVE](https://love2d.org/) for Windows, macOS, and Linux!

*Friday Night Funkin' Rewritten* features:
* A rewritten engine focused on performance and playability
* MUCH less memory usage than the original game
* Better fullscreen support
* Controller support
* And more to come!

Check it out on GameBanana: https://gamebanana.com/mods/55620
Join the Discord server for updates: https://discord.gg/tQGzN2Wu48

# Controls
If you are using a controller, a controller with an Xbox button layout is recommended. Controller buttons will be remappable in a future update.

## Menus
### Keyboard
* Arrow Keys - Select
* Enter - Confirm
* Escape - Back

### Controller
* Left Stick/D-Pad - Select
* A - Confirm
* B - Back

## Game
### Keyboard
* WASD/Arrow Keys - Arrows
* Enter - Confirm (Game Over)
* Escape - Exit

### Controller
* Left Stick/Right Stick/Shoulder Buttons/D-Pad/ABXY - Arrows
* A - Confirm (Game Over)
* Start - Exit

## Debug
### Keyboard
* 7 - Take Screenshot
  * Screenshot paths:
    * Windows - `%APPDATA%\funkin-rewritten\screenshots`
    * macOS - `~/Library/Application Support/funkin-rewritten/screenshots`
	* Linux - `~/.local/share/love/funkin-rewritten/screenshots`

# Settings
The settings file can be found in the following places on the following systems:
* Windows - `%APPDATA%\funkin-rewritten\settings.ini`
* macOS - `~/Library/Application Support/funkin-rewritten/settings.ini`
* Linux - `~/.local/share/love/funkin-rewritten/settings.ini`

# Progress
**Menus** - 25% Complete
* A proper menu has not been implemented yet. For now, a placeholder menu has been implemented.

**Game Engine** - 80% Complete
* Engine is in parity with Week 6's.
* No pause menu yet.
* Girlfriend is missing her accuracy and combo reactions.
* No "3-2-1-Go!" intro yet.
* See [Known Issues](#known-issues).

**Weeks** - ~4/8 Complete
* Tutorial + Weeks 1-4 are implemented.
* Week 3's train is not implemented yet.
* Week 4's passing car is not implemented yet.

# Known Issues
* Sprite offsets are a little weird and may need to be redone.
* On Linux, the screen can tear a lot if Vsync is set to 1. Set it to 0 in the `settings.ini` file to fix this.
  * This is an issue with LÖVE rather than the game itself.
* Game does not support 32-bit platforms because the amount of memory it uses.

# License
*Friday Night Funkin' Rewritten* is licensed under the terms of the GNU General Public License v3.

This means that your derivative works (mods, forks, etc.) of FNF Rewritten must be open-source! The build methods shown in this README technically make your code open-source anyway, but uploading it to GitHub is advised.

# Building
## Unix-like
### LOVE file
* Run `make`

Results are in `build/lovefile`.

### Windows (64-bit)
* Set up dependencies shown in `dependencies/win64/dependencies.txt`
* Run `make win64`

Results are in `build/win64`.

### Windows (32-bit)
* Set up dependencies shown in `dependencies/win32/dependencies.txt`
* Run `make win32`

Results are in `build/win32`.

### macOS
* Set up dependencies shown in `dependencies/macos/dependencies.txt`
* Run `make macos`

Results are in `build/macos`.

### Release ZIPs
* Set up dependencies shown in `dependencies/win64/dependencies.txt`
* Set up dependencies shown in `dependencies/win32/dependencies.txt`
* Set up dependencies shown in `dependencies/macos/dependencies.txt`
* Run `make release`

Results are in `build/release`.

## Other
Follow the official instructions for LÖVE game distribution for your platform: https://love2d.org/wiki/Game_Distribution

# Special Thanks
* KadeDev for [FNFDataAPI](https://github.com/KadeDev/FNFDataAPI), which was refrenced while developing the chart-reading system
* The devs of [BeatFever Mania](https://github.com/Sulunia/beatfever) for their music time interpolation code
* ninjamuffin99, PhantomArcade, kawaisprite, and evilsk8er, for making such an awesome game!
