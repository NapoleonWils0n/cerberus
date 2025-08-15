{
  description = "calibre";

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
          name = "calibre-shell";

          # build inputs 
          buildInputs = with pkgs; [
            calibre
          ];

          # Shell hook 
          shellHook = ''
            echo "You can now use 'calibre' directly."
          '';
        };
      });
}
