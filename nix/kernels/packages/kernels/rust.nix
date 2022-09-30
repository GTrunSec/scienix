{
  kernels,
  name,
  ...
} @ args: let
  inherit (args.inputs) cells;
in
  kernels.rust.override {
    name = "${name}-with-threat-intelligence";
    displayName = "${name} with threat intelligence";
  }
