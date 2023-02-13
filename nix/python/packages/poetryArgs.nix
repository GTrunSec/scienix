{
  inputs,
  cell,
}: {
  jupyenv ? false,
  groups ? [],
  cudaSupport ? false,
}: let
  inherit (cell.lib) nixpkgs;
  l = nixpkgs.lib // builtins;
in
  {
    projectDir = ./.;
    extraPackages = ps:
      with ps;
        [
          pandas
          seaborn
          (ps.pytorch.override {inherit cudaSupport;})
          # tensorflow
          matplotlib
          numpy
          python-lsp-server
          # nixpkgs.python3Packages.fastai
        ]
        ++ python-lsp-server.passthru.optional-dependencies.all;
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
