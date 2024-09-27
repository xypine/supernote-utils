# Use this to encode existing images to the format supported by the supernote
# ONLY TESTED ON GRAYSCALE PNGS ALREADY THE SIZE OF THE DEVICE (1404w x 1872h)
#
# Rotate 270 degrees (north becomes west)
# Discard top bits, supernote only uses values up to 0F map from 00-FF tp 00-0F
convert idle.png -rotate 270 -evaluate RightShift 4 -depth 8 -size 1872x1404+0 -fx "u*0.9375" gray:idle.bmp
