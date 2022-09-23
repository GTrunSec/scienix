{
  kernels,
  name,
  ...
} @ args: let
in
  kernels.bash.override {
    displayName = name;
    pkgs = args.inputs.nixpkgs;
  }
