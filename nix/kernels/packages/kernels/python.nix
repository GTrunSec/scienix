{
  kernels,
  name,
  ...
} @ args: let
  inherit (args.inputs) cells;
in
  kernels.python.override (cells.kernels.packages.poetryPackages
    // {
      name = "python-with-threat-intelligence";
      displayName = "python with threat intelligence";
    })
