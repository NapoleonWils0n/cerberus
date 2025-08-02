{
  description = "ollama-cuda";

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
            allowUnfree = true;
          };
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "ollama-dev-shell";

          packages = with pkgs; [
            ollama-cuda
          ];

          shellHook = ''
            source ${./shell-hook.sh}
            echo "You can now run 'ollama' by typing 'ollama serve'."
            echo "To exit, press Ctrl+c."
          '';
        };
      });
}
