{
  description = "A development shell for WhisperX with CUDA support (pip-based installation, targeting CUDA 12.x and cuDNN 8.x on NixOS 25.05).";

  inputs = {
    # Pinning to the latest NixOS unstable
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
        # Resolve the cudnn_8_9 path at Nix evaluation time.
        # If attribute doesn't exist, getAttrFromPath returns null.
        cudnn89Path = pkgs.lib.getAttrFromPath [ "cudaPackages" "cudnn_8_9" "out" ] pkgs;
      in
      {
        devShells.default = pkgs.mkShell rec {
          name = "whisperx-dev";

          # Essential build inputs for CUDA and Python environment
          buildInputs = with pkgs; [
            python312 # Python interpreter for creating the venv
            stdenv.cc.cc.lib # C standard library
            stdenv.cc        # C compiler
            cudaPackages.cudatoolkit # Default CUDA toolkit from NixOS 25.05 (likely 12.x)
          ] ++ pkgs.lib.optionals (cudnn89Path != null) [ pkgs.cudaPackages.cudnn_8_9 ] # Conditionally include cudnn_8_9 if its path was resolved (not null)
          ++ [
            linuxPackages.nvidia_x11 # Host NVIDIA X11 drivers (for libcuda.so)
            zlib # Common dependency
          ];

          # Environment variables required for CUDA and library linking
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
          CUDA_PATH = pkgs.cudaPackages.cudatoolkit;
          CUDA_HOME = pkgs.cudaPackages.cudatoolkit;
          EXTRA_LDFLAGS = "-L${pkgs.linuxPackages.nvidia_x11}/lib";
          # Pass the resolved cuDNN 8.9 path to the shell. Convert null to empty string for shell.
          NIX_CUDNN_8_9_PATH = if cudnn89Path != null then toString cudnn89Path else "";

          # Ensure CUDA binaries (like nvidia-smi) are in PATH for diagnostics
          PATH = pkgs.lib.makeBinPath [
            pkgs.cudaPackages.cudatoolkit
          ];

          # Shell hook to set up the Python virtual environment and install dependencies
          shellHook = ''
            echo "Entering WhisperX development shell with CUDA support (NixOS 25.05 stable, PyTorch cu121/cu122, attempting cuDNN 8.9)..."
            echo "Note: PyTorch and WhisperX will be installed via pip within a virtual environment."

            # Set the locale for consistent encoding
            export LC_ALL="en_US.UTF-8"
            export LANG="en_US.UTF-8"
            export PYTHONIOENCODING="utf-8"

            # Create and activate Python virtual environment
            if [ ! -d ".venv" ]; then
              echo "Creating Python virtual environment..."
              ${pkgs.python312}/bin/python3.12 -m venv .venv
            else
              echo "Re-activating existing Python virtual environment..."
            fi
            source .venv/bin/activate
            echo "Virtual environment activated."

            # Set CUDA variables
            export CUDA_VISIBLE_DEVICES=0
            export XDG_CACHE_HOME="$HOME/.cache"

            # Upgrade pip
            pip install --upgrade pip

            # Install torch torchaudio for CUDA 12.1/12.2 (trying general cu12x)
            echo "Installing latest stable torch and torchaudio for CUDA 12.x..."
            pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu121
            # If cu121 still resolves to 12.6, we might try cu122 or no specific version
            # If problems persist, consider explicit torch versions that are known to work with cuDNN 8.x and CUDA 12.x
            # Example: pip install torch==2.1.2 torchaudio==2.1.2 --index-url https://download.pytorch.org/whl/cu121

            # Install whisperx
            echo "Installing whisperx..."
            pip install -U whisperx

            echo "WhisperX setup complete. You can now use 'whisperx' command."
          '';
        };
      });
}
