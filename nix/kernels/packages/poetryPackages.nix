{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs cells;
in {
  pkgs = nixpkgs;
  python = nixpkgs.python39;
  projectDir = ./.;
  extraPackages = ps:
    with ps; [
      pandas
      # ps.matplotlib
      # seaborn
      numpy
    ];
  overrides = cells.julia.library.nixpkgs.poetry2nix.overrides.withDefaults (import ./overrides.nix);
}
