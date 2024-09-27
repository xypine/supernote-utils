# Can be used to decode existing on-device standby.bmp or to check the output of encode.sh
# Usage: encode [idle.bmp] [idle.png]

input_file=''${1:-idle.bmp}
output_file=''${2:-idle.png}
if [ ! -f "$input_file" ]; then
	echo "Error: Input file '$input_file' does not exist." >&2
	exit 1
fi
magick -depth 8 -size 1872x1404+0 gray:"${input_file}" -evaluate LeftShift 4 -rotate 90 "$output_file"
