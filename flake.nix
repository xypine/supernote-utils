{
  description = "Supernote Screensaver Utils";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        makeScript = name: script: pkgs.writeShellApplication {
          inherit name;
          runtimeInputs = [ pkgs.imagemagick ];
          text = builtins.readFile script;
        };

        encode-script = makeScript "snencode" ./snscreensaver/encode.sh;
        decode-script = makeScript "sndecode" ./snscreensaver/decode.sh;
      in
      {
        packages = {
          snencode = encode-script;
          sndecode = decode-script;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.imagemagick
            encode-script
            decode-script

            pkgs.nodejs
            pkgs.pnpm
            pkgs.chromium
          ];

          shellHook = ''
            echo "ImageMagick version: $(magick -version)"

            export PUPPETEER_EXECUTABLE_PATH=${pkgs.chromium.outPath}/bin/chromium
            export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
          '';
        };
      }
    );
}
