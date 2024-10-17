output="snss-auto-sync.zip"

cd magisk_module
zip -r -FS "../${output}" ./*
echo
echo "Magisk module built to ${output}"
