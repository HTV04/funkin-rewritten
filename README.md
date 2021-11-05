# Friday Night Funkin' Rewritten for Nintendo Switch (Legacy)
This is the *legacy* Nintendo Switch port of Funkin' Rewritten, compatible with the [LÖVE Potion](https://github.com/lovebrew/LovePotion) game engine. The latest versions of Funkin' Rewritten now use [love-nx](https://github.com/retronx-team/love-nx) for Nintendo Switch support and share code with the PC version, so you're probably looking for the `beta` branch if you want the most up-to-date code.

# License
*Friday Night Funkin' Rewritten* is licensed under the terms of the GNU General Public License v3, with the exception of most of the images, music, and sounds, which are proprietary. While FNF Rewritten's code is FOSS, use its assets at your own risk.

Also, derivative works (mods, forks, etc.) of FNF Rewritten must be open-source. The build methods shown in this README technically make one's code open-source anyway, but uploading it to GitHub or a similar platform is advised.

# Building
Building the Switch port of FNF Rewritten as a LOVE file is recommended since it's easier to set up and work with.

## Unix-like (macOS, Linux, etc.)
### LOVE file (Nintendo Switch)
* Run `make`

Results are in `./build/lovefile-switch-old`.

### Nintendo Switch
* Set up [devkitPro](https://devkitpro.org/wiki/Getting_Started)
  * Install the `switch-dev` package
* Set up dependencies shown in `./resources/switch-old/dependencies.txt`
* Run `make switch`

Results are in `./build/switch-old`.

### Release ZIPs
* Set up [devkitPro](https://devkitpro.org/wiki/Getting_Started)
  * Install the `switch-dev` package
* Set up dependencies shown in `./resources/switch-old/dependencies.txt`
* Run `make release`

Results are in `./build/release`.

## Other
Follow the official instructions for LÖVE Potion game distribution for your platform: https://lovebrew.org/#/packaging
