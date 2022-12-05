{
  inputs,
  cell,
}: let
  inherit (cell.lib) nixpkgs;
in {
  pkgs = nixpkgs;
  python = nixpkgs.python3;
  projectDir = ./.;
  extraPackages = ps:
    with ps; [
      pandas
      # seaborn
      tensorflow
      matplotlib
      nixpkgs.python3Packages.polars
      numpy
    ];
  ignoreCollisions = true;
  overrides = nixpkgs.poetry2nix.overrides.withDefaults (import ./overrides.nix nixpkgs);
}
