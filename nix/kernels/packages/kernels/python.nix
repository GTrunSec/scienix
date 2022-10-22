{
  kernels,
  name,
  ...
} @ args: let
  inherit (args.inputs) cells;
in
  kernels.python (cells.python.lib.poetryPackages
    // {
      name = "python-with-threat-intelligence";
      displayName = "python with threat intelligence";
    })
