#!/system/bin/sh

log_service() {
  # If the log path is bigger than 5MB, delete the oldest log
  if [ -f "$LOGPATH" ] && [ "$(wc -c <"$LOGPATH")" -gt 5000000 ]; then
    rm -f "$LOGPATH"
  fi

  # Write log to file
  echo "[$(date)] $*" >>"$LOGPATH"
}

log_service "[SNSSAUTOSYNC] Syncing at $(date +"%Y-%m-%d %T")"

# The screensaver id to replace
# I don't care enough to hunt for the db/config where the current image id is stored,
# the easiest way to obtain one is to:
# 1. remove all existing custom screensavers in the settings app
# 2. add one to be replaced, can be any valid custom screensaver
# 2. list all files in /data/vendor/eink/standby/
# 3 copy the value from the only origin_{ID} below
IMG_ID="1727457789845"

# Where screensavers have been generated to on the user-writable system
SOURCE="/sdcard/dynwp"


# Where to copy the converted bmp, this seems to be the only image displayed
NEW_IMG_BMP="${SOURCE}/idle.bmp"
# Copy PNGs as well for good measure
NEW_IMG_PNG="${SOURCE}/idle.png"
NEW_IMG_PNG_ROTATED="${SOURCE}/idle.png"


cp $NEW_IMG_BMP /data/vendor/eink/standby.bmp

# PNGs
cp $NEW_IMG_PNG /data/vendor/eink/standby/origin_${IMG_ID}
cp $NEW_IMG_PNG /data/vendor/eink/standby/${IMG_ID}.png
cp $NEW_IMG_PNG /data/vendor/eink/standby.png
cp $NEW_IMG_PNG_ROTATED /data/vendor/eink/standby_180.png
