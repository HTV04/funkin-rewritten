# ![Logo](images/logo.png)
*Friday Night Funkin' Rewritten* is a rewrite of [*Friday Night Funkin'*](https://ninja-muffin24.itch.io/funkin) in [*LÖVE*](https://love2d.org/) for Windows and Linux! macOS version coming soon!

*Friday Night Funkin' Rewritten* features:
* A rewritten engine focused on speed, performance, and playability!
* Better fullscreen support (proper Vsync, which means no screen tear)!
* Controller support!
* And more to come!

# Overview
*Friday Night Funkin'* is an awesome game, the gameplay, visuals, and music are amazing! However, I have a few pet peeves with the game engine. It feels weirdly sluggish at times, even on the desktop version. Fullscreen is also weird, the video is capped at 60 FPS but the game is runs at a higher framerate, causing a lot of screen tear. Additionally, some things just feel wrong, like the arrows being off-center, and the "visual beats" (screen and UI zooming in to match the BPS) look really weird, especially on the UI.

Others have tried to fix these issues by modifying the game's code, since it's an [open-source](https://github.com/ninjamuffin99/Funkin) game. However, some of these modifications are closed-source, so nobody knows how these issues were fixed, and others are open-source, but still have similar performance issues to those mentioned above (especially the screen tear, what's up with that?).

So, out of boredom, and since I want to give myself a challenge as an apsiring game developer, I decided to rewrite *Friday Night Funkin'* from scratch (well, mostly, anyway). I wanted to choose a framework that I was more familiar with and felt had good performance (no offense, *HaxeFlixel*), so I chose *LÖVE*, a very powerful framework for 2D games that uses Lua as its programming language.

After about a week's worth of work on the game, I finished the first beta version of *Friday Night Funkin' Rewritten*! I designed it to feel and play as close to the original engine as possible, while fixing the above issues, along with adding some other cool features! It's currently in beta, so it isn't finished yet. Try it out, and don't hesitate to give me feedback on how I can improve it!

Oh, and it's [open-source](https://github.com/HTV04/funkin-rewritten)! Feel free to modify it or contribute.

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
    * Windows - `%APPDATA&\funkin-rewritten\screenshots`
    * Linux - `~/.local/share/love/funkin-rewritten/screenshots`

# Settings
The settings file can be found in the following places on the following systems:
* Windows - `%APPDATA&\funkin-rewritten\settings.ini`
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

**Weeks** - 2.8/7 Complete
* Weeks 1-3 are implemented.
* Week 3's train is not implemented yet.

# Known Issues
* Pressing multiple keys/buttons at once doesn't register properly in-game.
* Sprite offsets are a little weird and may need to be redone.
* On Linux, the screen can tear a lot if Vsync is set to 1. Set it to 0 in the `settings.ini` file to fix this.
  * This is an issue with *LÖVE* rather than the game itself.
* Game does not support 32-bit platforms because the amount of memory it uses.

# Special Thanks
* KadeDev for [FNFDataAPI](https://github.com/KadeDev/FNFDataAPI/tree/main/FNFDataAPI), which was refrenced while developing the chart-reading system
* The devs of [BeatFever Mania](https://github.com/Sulunia/beatfever) for their music time interpolation code
* ninjamuffin99, PhantomArcade, kawaisprite, and evilsk8er, for making such an awesome game!
