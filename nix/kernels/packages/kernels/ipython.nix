{
  mkKernel,
  kernels,
  name,
  ...
} @ args: let
  ipython = kernels.ipython.override {
    pkgs = args.inputs.nixpkgs;
    python = args.inputs.nixpkgs.python39;
    extraPackages = args.cell.packages.pythonPackages;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
  };
in
  mkKernel ipython {
    displayName = name;
  }
