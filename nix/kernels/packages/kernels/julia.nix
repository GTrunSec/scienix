{
  kernels,
  name,
  ...
} @ args: let
  julia = kernels.julia.override {
    pkgs = args.inputs.nixpkgs;
    julia-bin = args.inputs.julia2nix.packages.${args.nixpkgs.system}.julia_18-bin;
  };
in
  julia {
    displayName = name;
  }
