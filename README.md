# Friday Night Funkin' Rewritten

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/HTV04/funkin-rewritten?style=flat-square)](https://github.com/HTV04/funkin-rewritten/releases/latest)
[![GitHub all releases](https://img.shields.io/github/downloads/HTV04/funkin-rewritten/total?style=flat-square)](https://github.com/HTV04/funkin-rewritten/releases)
[![GitHub issues](https://img.shields.io/github/issues/HTV04/funkin-rewritten?style=flat-square)](https://github.com/HTV04/funkin-rewritten/issues)
[![GitHub](https://img.shields.io/github/license/HTV04/funkin-rewritten?style=flat-square)](https://github.com/HTV04/funkin-rewritten/blob/main/LICENSE)

[Friday Night Funkin' Rewritten](https://github.com/HTV04/funkin-rewritten) is a rewrite of [Friday Night Funkin'](https://ninja-muffin24.itch.io/funkin) built on [LÖVE](https://love2d.org/) for Windows, macOS, Linux, and Web platforms, as well as previously unsupported platforms, like the Nintendo Switch.

Friday Night Funkin' Rewritten features:
* A rewritten engine focused on performance and playability
* Much less memory usage than the original game
* Controller support
* Other cool features, like downscroll

## Controls

If using a controller on a PC, a controller with an Xbox button layout is recommended. Controller buttons will be remappable in a future update.

### Menus

* Keyboard
  * Arrow Keys - Select
  * Enter - Confirm
  * Escape - Back
* Controller
  * Left Stick/D-Pad - Select
  * A - Confirm
  * B - Back

### Game

* Keyboard
  * WASD/Arrow Keys - Arrows
  * Enter - Confirm (Game Over)
  * Escape - Exit
* Controller
  * Left Stick/Right Stick/Shoulder Buttons/D-Pad/ABXY - Arrows
  * A - Confirm (Game Over)
  * Start - Exit

### Debug

* Keyboard
  * 6 - Take screenshot
    * Screenshot directory:
      * Windows - `%APPDATA%\funkin-rewritten\screenshots`
      * macOS - `~/Library/Application Support/funkin-rewritten/screenshots`
	  * Linux - `~/.local/share/love/funkin-rewritten/screenshots`
	  * Nintendo Switch - `./funkin-rewritten/screenshots`
  * 7 - Open debug menu

## Settings

The settings file can be found in the following places on the following systems:
* Windows - `%APPDATA%\funkin-rewritten\settings.ini`
* macOS - `~/Library/Application Support/funkin-rewritten/settings.ini`
* Linux - `~/.local/share/love/funkin-rewritten/settings.ini`
* Nintendo Switch - `./funkin-rewritten/settings.ini`

## To-Do

**Menus**
* A proper menu has not been implemented yet. For now, a placeholder menu has been implemented.

**Game Engine**
* No pause menu yet.

**Weeks**
* Week 3's train is not added yet.
* Week 4's passing car is not added yet.
* Week 6 is a WIP.

## Building

### Unix-like (macOS, Linux, etc.)

After running a build method, its release ZIP will be located at `./build/release`.

* ".love-file"
  * Run `make lovefile`
* Windows (64-bit)
  * Set up dependencies shown in `./resources/win64/dependencies.txt`
  * Run `make win64`
* Windows (32-bit)
  * Set up dependencies shown in `./resources/win32/dependencies.txt`
  * Run `make win32`
* macOS
  * Set up dependencies shown in `./resources/macos/dependencies.txt`
  * Run `make macos`
* Nintendo Switch
  * Set up [devkitPro](https://devkitpro.org/wiki/Getting_Started)
    * Install the `switch-dev` package
  * Set up dependencies shown in `./resources/switch/dependencies.txt`
  * Run `make switch`
* Web
  * The current method for building the web version is not portable, so I've decided to omit the instructions for doing so in the meantime.

### Other

Follow the official instructions for LÖVE game distribution for your platform: https://love2d.org/wiki/Game_Distribution

## License

*Friday Night Funkin'* and its logo are trademarked. Its images, music, and sounds are under a [proprietary license](https://github.com/FunkinCrew/funkin.assets/blob/main/LICENSE.md).

Anything that is not derived from the assets of *Friday Night Funkin'* is licensed under the terms of the [GNU General Public License v3](LICENSE). This mainly includes the source code (Lua files).

As of writing, I (HTV04) have no affiliation with Funkin' Crew Inc. Please contact me for any inquries: contact@htv04.com

## Special Thanks

* KadeDev for [FNFDataAPI](https://github.com/KadeDev/FNFDataAPI), which was referenced while developing the chart-reading system
* The developers of [BeatFever Mania](https://github.com/Sulunia/beatfever) for their music time interpolation code
* The developers of the [LÖVE](https://love2d.org/) framework, for making Funkin' Rewritten possible
* p-sam for developing [love-nx](https://github.com/retronx-team/love-nx), used for the Nintendo Switch version of the game
* Davidobot for developing [love.js](https://github.com/Davidobot/love.js), used for the Web version of the game
* TurtleP for developing [LÖVE Potion](https://github.com/lovebrew/LovePotion), originally used for the Nintendo Switch version of the game
* Funkin' Crew, for making such an awesome game
