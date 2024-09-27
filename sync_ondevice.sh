# Where to copy the converted bmp, this seems to be the only image displayed
export NEW_IMG_BMP="/sdcard/EXPORT/idle.bmp"
# Copy PNGs as well for good measure
export NEW_IMG_PNG="/sdcard/EXPORT/idle.png"
export NEW_IMG_PNG_ROTATED="/sdcard/EXPORT/idle.png"

# The screensaver to replace
# I don't care enough to hunt for the db/config where the current image id is stored,
# the easiest way to obtain one is to:
# 1. remove all existing screensavers in the settings app
# 2. add one to be replaced, can be any valid custom screensaver
# 2. list all files in /data/vendor/eink/standby/
# 3 copy the value from the only origin_{ID} below
export IMG_ID="1727457789845"

cp $NEW_IMG_BMP /data/vendor/eink/standby.bmp

# PNGs
cp $NEW_IMG_PNG /data/vendor/eink/standby/origin_${IMG_ID}
cp $NEW_IMG_PNG /data/vendor/eink/standby/${IMG_ID}.png
cp $NEW_IMG_PNG /data/vendor/eink/standby.png
cp $NEW_IMG_PNG_ROTATED /data/vendor/eink/standby_180.png
