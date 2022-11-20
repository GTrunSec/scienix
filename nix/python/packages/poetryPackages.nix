{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs cells;
in {
  pkgs = nixpkgs;
  python = nixpkgs.python3;
  projectDir = ./.;
  extraPackages = ps:
    with ps; [
      pandas
      # matplotlib
      # seaborn
      polars
      numpy
    ];
  overrides = cells.julia.lib.nixpkgs.poetry2nix.overrides.withDefaults (import ./overrides.nix);
}
