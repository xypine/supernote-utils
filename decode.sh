# Can be used to decode existing on-device standby.bmp or to check the output of encode.sh
convert -depth 8 -size 1872x1404+0 gray:idle.bmp -evaluate LeftShift 4 -rotate 90 out.png
