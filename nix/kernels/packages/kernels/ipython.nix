{
  k,
  name,
  ...
} @ args: let
  ipython = k.ipython.override {
    pkgs = args.inputs.nixpkgs;
    python = args.inputs.nixpkgs.python39;
    extraPackages = args.cell.packages.pythonPackages;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
  };
in
  ipython {
    displayName = name;
  }
