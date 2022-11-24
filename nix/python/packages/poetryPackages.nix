{
  inputs,
  cell,
}: let
  inherit (inputs) cells;
  inherit (cell.lib) nixpkgs;
in {
  pkgs = nixpkgs;
  python = nixpkgs.python3;
  projectDir = ./.;
  extraPackages = ps:
    with ps; [
      pandas
      # matplotlib
      # seaborn
      cell.lib.nixpkgs.python3Packages.polars
      numpy
    ];
  overrides = nixpkgs.poetry2nix.overrides.withDefaults (import ./overrides.nix);
}
