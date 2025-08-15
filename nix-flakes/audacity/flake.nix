{
  description = "audacity";

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
          name = "audacity-shell";

          # build inputs 
          buildInputs = with pkgs; [
            audacity
          ];

          # Shell hook 
          shellHook = ''
            echo "You can now use 'audacity' directly."
          '';
        };
      });
}
