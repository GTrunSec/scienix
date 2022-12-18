{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  inherit (cell.lib.nixpkgs.python3Packages) polars;

  mkPoetryEnv = (cell.lib.nixpkgs.poetry2nix.mkPoetryEnv
    (builtins.removeAttrs cell.lib.poetryPackages ["pkgs" "ignoreCollisions"]))
  .override (old: {ignoreCollisions = true;});

  mkPoetryOpenCTI = cell.lib.nixpkgs.poetry2nix.mkPoetryEnv {
    projectDir = ./opencti;
    overrides = cell.lib.nixpkgs.poetry2nix.overrides.withDefaults (import ./opencti/overrides.nix);
  };

  mkPythonEnv =
    cell.lib.nixpkgs.python3.buildEnv.override
    {
      # extraLibs = inputs.cells.python.lib.poetryPackages.extraPackages nixpkgs.python3Packages;
      extraLibs = with cell.lib.nixpkgs.python3Packages; [
        polars
      ];
      # not recommended
      # ignoreCollisions = true;
    };

  # mkMachEnv = cell.lib.nixpkgs.machlib.mkPython {
  #   requirements = ''
  #     numpy
  #     pandas
  #     polars
  #     scanpy
  #     anndata
  #     matplotlib
  #     seaborn
  #   '';
  #   overridesPre = [
  #     (
  #       self: super: {
  #         inherit
  #           (cell.lib.nixpkgs.python3Packages)
  #           polars
  #           ;
  #       }
  #     )
  #   ];
  #   packagesExtra = [];
  #   python = "python3";
  #   providers = {};
  # };
}
