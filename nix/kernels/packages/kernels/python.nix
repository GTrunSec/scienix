{
  kernels,
  name,
  ...
} @ args: let
  inherit (args.inputs) cells;
in
  kernels.python.override (cells.python.packages.poetryPackages
    // {
      name = "python-with-threat-intelligence";
      displayName = "python with threat intelligence";
    })
