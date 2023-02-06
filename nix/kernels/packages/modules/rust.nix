{
  kernels,
  name,
  ...
} @ args: let
  inherit (args.inputs) cells;
in
  kernels.rust.override {
    displayName = name;
  }
