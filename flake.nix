{
  description = "Program to upload scrobbles from DAPs";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      app = pkgs.libsForQt5.callPackage ./package.nix {};
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = {
        qtscrob = app;
        default = self.packages.${system}.qtscrob;
      };
    });
}
