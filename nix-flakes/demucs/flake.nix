{
  description = "A development shell for Demucs with CUDA support";

  inputs = {
    nixpkgs.url = "github:NixOS/Nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      in
      {
        devShells.default = pkgs.mkShell rec {
          name = "demucs-cuda-shell";

          buildInputs = with pkgs; [
            python311         # Demucs plays very well with 3.11
            stdenv.cc.cc.lib
            stdenv.cc
            cudaPackages.cudatoolkit 
            cudaPackages.cudnn  
            linuxPackages.nvidia_x11 
            zlib
            pkg-config 
            ffmpeg            # Essential for Demucs audio IO
            libsndfile        # Required for high-quality audio saving
          ];

          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
          CUDA_PATH = pkgs.cudaPackages.cudatoolkit;
          CUDA_HOME = pkgs.cudaPackages.cudatoolkit;
          EXTRA_LDFLAGS = "-L${pkgs.linuxPackages.nvidia_x11}/lib";

          # Ensure CUDA binaries (like nvidia-smi) are in PATH for diagnostics
          PATH = pkgs.lib.makeBinPath [
            pkgs.cudaPackages.cudatoolkit
          ];

          shellHook = ''
            echo "Entering Demucs CUDA development shell"
            
            # Create and activate Python virtual environment
            if [ ! -d ".venv-demucs" ]; then
              echo "Creating Demucs virtual environment..."
              ${pkgs.python311}/bin/python3.11 -m venv .venv
            fi
            source .venv/bin/activate

            # Set CUDA variables
            export CUDA_VISIBLE_DEVICES=0
            export XDG_CACHE_HOME="$HOME/.cache"

            # Upgrade pip and install Torch with CUDA support
            pip install --upgrade pip

            # Upgrade pip and install Torch with CUDA support
            pip install --upgrade pip
            
            # Using the standard PyTorch CUDA 12.1+ index which is stable for Demucs
            pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

            # Install Demucs
            pip install -U demucs diffq soundfile

            echo "---------------------------------------------------------"
            echo "Demucs is ready! To separate a track, run:"
            echo "demucs --two-stems=vocals 'your_file.mp3'"
            echo "---------------------------------------------------------"
          '';
        };
      });
}
