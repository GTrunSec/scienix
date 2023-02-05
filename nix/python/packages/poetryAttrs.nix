{
  inputs,
  cell,
}: {
  jupyenv ? false,
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
        seaborn
        (ps.pytorch.override { cudaSupport = true; })
        # tensorflow
        matplotlib
        numpy
        # nixpkgs.python3Packages.fastai
      ];
    overrides = nixpkgs.poetry2nix.overrides.withDefaults (import ./overrides.nix);
    inherit groups;
    preferWheels = true;
  }
  // (l.optionalAttrs jupyenv {
    ignoreCollisions = true;
    inherit nixpkgs;
    python = "python3";
    overrides = ./overrides.nix;
    groups = ["jupyenv"];
  })
