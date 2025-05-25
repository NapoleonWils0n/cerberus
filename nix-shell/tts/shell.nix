{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [ pkgs.tts ];

  shellHook = ''
    echo "Coqui TTS environment loaded.  Run 'tts --help' for usage."
  '';
}
