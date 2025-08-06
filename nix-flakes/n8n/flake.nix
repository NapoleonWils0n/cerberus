{
  description = "n8n";

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
          name = "n8n-dev-shell";

          # build inputs 
          buildInputs = with pkgs; [
            n8n
          ];

          # Shell hook 
          shellHook = ''
            echo "Welcome to the n8n development shell!"
            echo "You can now run 'n8n' directly by typing 'n8n'."
            echo "To exit, press Ctrl+c."
          '';
        };
      });
}
