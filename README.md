# Utilities for changing the supernote screensaver periodically

Needs ROOT access to copy the encoded image to a system folder. Rooting may harm your system and you are solely responsible for what you do with your device. 

[Guide to rooting the supernote A6X2](https://github.com/dwongdev/sugoi-supernote/blob/main/Guides/How%20to%20root%20SN%20A6X2.md)

Latest tested firmware: Chauvet 3.18.29

## Example Workflow:
1. Generate screensaver using some program (for example, calendar, flickr, etc.)
2. Save image as grayscale 1404x1872 png to idle.png
3. Run snencode
4. Upload the encoded idle.bmp and the original idle.png to the device (syncthing, crontab, etc.)
5. Run sync_ondevice.sh on the supernote as root.
6. Enjoy your new screensaver!

## Dependencies:
- [ImageMagick](https://imagemagick.org/) (Tested on version 7.1.1-38)

A flake.nix is included containing an exact, working version. 

On a system supporting Nix flakes, you can:
- enter a dev environment with the necessary dependencies by running `nix develop` in the project directory

or

- run `snencode` anywhere by running `nix run github:xypine/supernote-utils#snencode`
- run `sndecode` anywhere by running `nix run github:xypine/supernote-utils#sndecode`

Using `nix run` all dependencies are installed automatically (if you don't have them installed already).

## Notes:
While the extension of the output is .bmp by default (following the convention of the supernote system file), it is not a valid .bmp file.

A valid .bmp file would include headers which are not used here since the width, height, and color depth of the image are presumably static.

## Building static executables for non-Nix systems
Requires a system with Nix flakes support. Use `nix bundle .#snencode && nix bundle .#sndecode` to produce binaries containing the scripts _and_ the required dependencies, note that the binaries may be slow to start.
