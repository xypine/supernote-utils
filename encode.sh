# Use this to encode existing images to the format supported by the supernote
# ONLY TESTED ON GRAYSCALE PNGS ALREADY THE SIZE OF THE DEVICE (1404w x 1872h)
#
# Usage: encode [idle.png] [idle.bmp]

# Rotate 270 degrees (north becomes west)
# Discard top bits, supernote only uses values up to 0F map from 00-FF tp 00-0F
input_file=''${1:-idle.png}
output_file=''${2:-idle.bmp}
if [ ! -f "$input_file" ]; then
	echo "Error: Input file '$input_file' does not exist." >&2
	exit 1
fi
magick "$input_file" -rotate 270 -evaluate RightShift 4 -depth 8 -size 1872x1404+0 -fx "u*0.9375" gray:"${output_file}"
