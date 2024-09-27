# Utilities for changing the supernote screensaver periodically

Needs ROOT access to copy the encoded image to a system folder. Rooting may harm your system and you are solely responsible for what you do with your device. 

[Guide to rooting the supernote A6X2](https://github.com/dwongdev/sugoi-supernote/blob/main/Guides/How%20to%20root%20SN%20A6X2.md)

Latest tested firmware: Chauvet 3.18.29


## Workflow:
1. Generate screensaver using some program (for example, calendar, flickr, etc.)
2. Save image as grayscale 1404x1872 png to idle.png
3. Run encode.sh
4. Upload the encoded idle.bmp and the original idle.png to the device (syncthing, crontab, etc.)
5. Run sync_ondevice.sh on the supernote as root.
6. Enjoy your new screensaver!
