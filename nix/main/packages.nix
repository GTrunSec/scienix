{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
in {
  inherit
    (inputs.cells.julia.packages)
    julia-wrapped
    jnumpy
    ;
  # pythonEnv =
  #   nixpkgs.python3.buildEnv.override
  #   {
  #     extraLibs = inputs.cells.kernels.packages.pythonPackages nixpkgs.python3Packages;
  #     ignoreCollisions = true;
  #   };
  poetryPython = inputs.cells.julia.library.nixpkgs.poetry2nix.mkPoetryEnv {
    python = nixpkgs.python39;
    projectDir = ../kernels/packages;
    extraPackages = inputs.cells.kernels.packages.pythonPackages;
  };
}
