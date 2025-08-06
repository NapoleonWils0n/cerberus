{
  description = "A development shell for OpenAI Whisper with CUDA support.";

  inputs = {
    # Pinning to the latest unstable NixOS release for better CUDA stability
    nixpkgs.url = "github:NixOS/Nixpkgs/nixos-unstable"; 
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true; # Necessary for NVIDIA drivers and CUDA
          };
        };
      in
      {
        devShells.default = pkgs.mkShell rec {
          name = "whisper-dev";

          # Essential build inputs for CUDA and Python environment
          buildInputs = with pkgs; [
            python312
            stdenv.cc.cc.lib
            stdenv.cc
            cudaPackages.cudatoolkit # Using the general cudatoolkit from the stable channel
            linuxPackages.nvidia_x11 # Host NVIDIA X11 drivers
            zlib
          ];

          # Environment variables required for CUDA and library linking
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
          CUDA_PATH = pkgs.cudaPackages.cudatoolkit;
          CUDA_HOME = pkgs.cudaPackages.cudatoolkit;
          EXTRA_LDFLAGS = "-L${pkgs.linuxPackages.nvidia_x11}/lib";

          # Ensure CUDA binaries (like nvidia-smi) are in PATH for diagnostics
          PATH = pkgs.lib.makeBinPath [
            pkgs.cudaPackages.cudatoolkit
          ];

          # Shell hook to set up the Python virtual environment and install dependencies
          shellHook = ''
            echo "Setting up environment for Whisper with CUDA (NixOS 25.05 stable)..."

            export LC_ALL="en_US.UTF-8"
            export LANG="en_US.UTF-8"
            export PYTHONIOENCODING="utf-8"

            if [ ! -d ".venv" ]; then
              echo "Creating Python virtual environment..."
              ${pkgs.python312}/bin/python3.12 -m venv .venv
            else
              echo "Re-activating existing Python virtual environment..."
            fi
            source .venv/bin/activate
            echo "Virtual environment activated."

            export CUDA_VISIBLE_DEVICES=0
            export XDG_CACHE_HOME="$HOME/.cache"

            pip install --upgrade pip

            echo "Installing torch and torchaudio for CUDA 12.1..."
            pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu121

            echo "Installing openai-whisper..."
            pip install -U openai-whisper

            echo "Whisper setup complete."
          '';
        };
      });
}
