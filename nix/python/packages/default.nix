{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
  poetryPackages = import ./poetryPackages.nix args;
in {
  inherit poetryPackages;

  poetryEnv =
    inputs.cells._automation.lib.nixpkgs.poetry2nix.mkPoetryEnv
    (builtins.removeAttrs cell.packages.poetryPackages ["pkgs"]);

  pythonEnv =
    nixpkgs.python3.buildEnv.override
    {
      extraLibs = inputs.cells.kernels.packages.pythonPackages nixpkgs.python3Packages;
      ignoreCollisions = true;
    };
}
