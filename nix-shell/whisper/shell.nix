{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.python311Packages.openai-whisper.override {
      triton = pkgs.python311Packages.triton-cuda;
      torch = pkgs.python311Packages.pytorch-bin.override {
        triton = pkgs.python311Packages.triton-cuda;
      };
    })
    pkgs.cudaPackages.cudatoolkit
  ];

  shellHook = ''
    echo "Welcome to the Whisper CUDA environment!"
    echo "Run 'whisper input.mp3 --model small --device cuda' to transcribe."
  '';
}
