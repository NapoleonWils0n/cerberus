{ pkgs ? import <nixpkgs> {} }:

let
  pythonPackages = pkgs.python312Packages;
in
pkgs.mkShell {
  name = "kokoro-tts";
  # Increase stack size.
  NIX_SHELL_SET_LOCALE = "en_US.UTF-8";
  shellHook = ''
    echo "ulimit -s unlimited"
    # Set the locale.
    export LC_ALL="en_US.UTF-8"
    export LANG="en_US.UTF-8"
    export PYTHONIOENCODING="utf-8"

    if [ ! -d ".venv" ]; then
      echo "Creating Python virtual environment using Nix-provided Python..."
      ${pkgs.python312}/bin/python3.12 -m venv .venv
    else
      echo "Re-activating existing Python virtual environment..."
    fi
    source .venv/bin/activate
    echo "Virtual environment activated."

    pip install -q "kokoro>=0.9.4" soundfile

    export CUDA_VISIBLE_DEVICES=0 # Or adjust if you have multiple GPUs
    export XDG_CACHE_HOME="$HOME/.cache" # Ensure a valid cache directory
    export PATH="$PATH:${pkgs.cudaPackages.cudatoolkit}/bin" # Corrected path. Adjust version as needed.
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.cudaPackages.cudatoolkit}/lib:${pkgs.cudaPackages.cudatoolkit}/lib64:${pkgs.stdenv.cc.cc.lib}/lib" # Include stdenv

  '';

  # Minimal buildInputs for CUDA 12
  buildInputs = [
    pkgs.espeak
    pkgs.python312 # Ensure base python is available
    pythonPackages.setuptools
    pythonPackages.wheel
    pkgs.cudaPackages.cudatoolkit # Default CUDA (likely 12.x)
    pkgs.cudaPackages.cudnn
    pkgs.stdenv.cc.cc # Include the compiler
    pkgs.python312Packages.ipython
  ];
}
