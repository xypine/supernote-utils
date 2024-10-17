#!/system/bin/sh

export MODDIR="${0%/*}"
export MODPATH="$MODDIR"
export TMPDIR="$MODDIR"/tmp
export LOGPATH="$MODDIR"/service.log

log_service() {
  # If the log path is bigger than 5MB, delete the oldest log
  if [ -f "$LOGPATH" ] && [ "$(wc -c <"$LOGPATH")" -gt 5000000 ]; then
    rm -f "$LOGPATH"
  fi

  # Write log to file
  echo "[$(date)] $*" >>"$LOGPATH"
}

abort() {
  log_service "$*"
  exit 1
}

wait_until_boot_complete() {
  loop_count=0
  until [ "$(getprop init.svc.bootanim)" = "stopped" ] && [ "$(getprop sys.boot_completed)" = "1" ] && [ -d /sdcard ]; do
    # CHECK
    if [ "$loop_count" -gt 10 ]; then
      log_service "Exceeded the maximum number of retries for loading the service."
      abort "Boot Animation: $(getprop init.svc.bootanim) | Boot Complete: $(getprop sys.boot_completed) | /sdcard: $(if [ -d /sdcard ]; then echo "Exists"; else echo "Does not exist"; fi)"
    fi

    # WAIT
    sleep 3
    loop_count=$((loop_count + 1))
  done
}

log_service "starting SNSSAUTOSYNC"
log_service "waiting for boot to complete"
wait_until_boot_complete
log_service "System fully started. Running main loop..."

while true; do
    # Run your script
    log_service "[SNSSAUTOSYNC] calling script"
    sh "$MODDIR/sync_idlewp.sh" > /sdcard/snssautosync.log

    # Wait for 5 minutes (300 seconds)
    sleep 300
done
