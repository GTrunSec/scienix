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
      matplotlib
      # seaborn
      numpy
    ];
  overrides = cells.julia.library.nixpkgs.poetry2nix.overrides.withDefaults (import ./overrides.nix);
}
