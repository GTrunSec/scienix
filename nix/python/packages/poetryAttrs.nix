{
  inputs,
  cell,
}: {
  jupyterWith ? false,
  groups ? [],
}: let
  inherit (cell.lib) nixpkgs;
  l = nixpkgs.lib // builtins;
in
  {
    projectDir = ./.;
    extraPackages = ps:
      with ps; [
        pandas
        # seaborn
        tensorflow
        matplotlib
        nixpkgs.python3Packages.polars
        numpy
        nixpkgs.python3Packages.fastai
      ];
    overrides = nixpkgs.poetry2nix.overrides.withDefaults (import ./overrides.nix nixpkgs);
    inherit groups;
  }
  // (l.optionalAttrs jupyterWith {
    ignoreCollisions = true;
    pkgs = nixpkgs;
    python = nixpkgs.python3;
    groups = ["jupyterWith"];
  })
