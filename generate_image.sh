# Requires wget, snencode and the dependencies of generator to be installed, see generator/ for those
# Easiest setup (nix with flakes):
# - nix develop
# - cd generator && pnpm i && cd .. # First time only
# - ./generate_image.sh

cd generator
# Run the server in the background and store the PID for later
pnpm --silent live &
SERVER_PID=$!
echo "Web server started with PID $SERVER_PID"
# Kill the webserver (and other subprocesses) when we exit
trap "echo 'Cleaning up...'; trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT
cd ..

# Wait for vite to start up
sleep 2
# Download (generate) idle.png
wget -q --show-progress http://localhost:5173/idle.png -O idle.png

# Encode idle.png to the format used on the supernote
echo "Encoding idle.png to idle.bmp ..."
snencode ./idle.png ./idle.bmp

echo "Done!"
# Webserver gets killed automatically here
