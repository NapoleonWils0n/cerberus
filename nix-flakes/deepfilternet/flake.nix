{
  description = "DeepFilterNet CLI binary for audio cleanup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        
        hdf5-combined = pkgs.symlinkJoin {
          name = "hdf5-combined";
          paths = [ pkgs.hdf5.out pkgs.hdf5.dev ];
        };
        
        targetTriple = pkgs.stdenv.targetPlatform.config;
        # *** FIX 1: Change space-separated features to comma-separated features ***
        requiredFeatures = "bin,tract,wav-utils,transforms";
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            (pkgs.deepfilternet.overrideAttrs (oldAttrs: {
              pname = "deep-filter";
              
              # Pass binary target, disable defaults, and pass comma-separated features
              cargoBuildFlags = [
                "--bin" "deep-filter"
                "--no-default-features"
                "--features" requiredFeatures 
              ];
              
              buildAndTestSubdir = null;
              doCheck = false; 

              # Dependency fixes remain the same
              nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ 
                pkgs.pkg-config 
                pkgs.python3 
              ];
              buildInputs = (oldAttrs.buildInputs or []) ++ [ 
                pkgs.hdf5
                pkgs.alsa-lib
                pkgs.libjack2
                pkgs.pipewire
              ];

              HDF5_DIR = "${hdf5-combined}";

              preBuild = ''
                export LIBHDF5_PATH="${pkgs.hdf5.out}/lib"
              '';

              # Install from the explicit target directory
              postInstall = ''
                echo "Installing the explicitly compiled deep-filter binary..."
                
                BINARY_PATH="target/${targetTriple}/release/deep-filter"
                
                if [ -f "$BINARY_PATH" ]; then
                  echo "Found binary at: $BINARY_PATH"
                  install -Dm755 "$BINARY_PATH" "$out/bin/deep-filter"
                else
                  echo "Error: Binary not found after explicit compilation!"
                  find target -maxdepth 5
                  exit 1
                fi
              '';
            }))
          ];

          shellHook = ''
            echo "--- DeepFilterNet CLI Environment ---"
            if command -v deep-filter &> /dev/null; then
              echo "✅ SUCCESS: 'deep-filter' is available."
              deep-filter --version
            else
              echo "❌ Final attempt failed."
            fi
          '';
        };
      }
    );
}

