{
  description = "gemini-cli";

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
          name = "gemini-cli-shell";

          # build inputs 
          buildInputs = with pkgs; [
            gemini-cli
          ];

          # Shell hook 
          shellHook = ''
            echo "Welcome to the gemini-cli development shell!"
            echo "You can now use 'gemini' directly."
          '';
        };
      });
}
