{
  description = "Qwen3-TTS development shell with CUDA support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true; # Necessary for NVIDIA drivers and CUDA
            cudaSupport = true; 
          };
        };
      in
      {
        devShells.default = pkgs.mkShell rec {
          name = "qwen-tts-dev";

          # System dependencies for Qwen3-TTS audio processing
          buildInputs = with pkgs; [
            python312
            stdenv.cc.cc.lib
            stdenv.cc
            # CUDA stack
            cudaPackages.cudatoolkit 
            cudaPackages.cudnn
            linuxPackages.nvidia_x11
            pkg-config 
            zlib
            # Essential media libraries for soundfile/sox/ffmpeg
            ffmpeg
            sox
            libsndfile
            libiconv
            libxml2
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

          shellHook = ''
            # Set the locale for consistent encoding
            export LC_ALL="en_US.UTF-8"
            export LANG="en_US.UTF-8"
            export PYTHONIOENCODING="utf-8"


            # Setup Venv
            if [ ! -d ".venv" ]; then
              ${pkgs.python312}/bin/python3.12 -m venv .venv
            fi
            source .venv/bin/activate

            # Set CUDA variables
            export CUDA_VISIBLE_DEVICES=0
            export XDG_CACHE_HOME="$HOME/.cache"

            # Install Qwen3-TTS and Torch for CUDA 12+ (standard for NixOS Unstable)
            pip install --upgrade pip

            # Set environment variable to prevent silent async CUDA errors (Crucial for debugging low-level crashes)
            export CUDA_LAUNCH_BLOCKING=1
            export TORCH_FORCE_NO_WEIGHTS_ONLY_LOAD=true

            # cuda 13
            pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu130

            # pip instal qwen-tts
            pip install -U qwen-tts 

            echo "--- Qwen3-TTS Nix Environment Ready ---"
            echo "To run the demo on your 4GB VRAM card, use:"
            echo "qwen-tts-demo Qwen/Qwen3-TTS-12Hz-0.6B-Base --no-flash-attn"
          '';
        };
      });
}
