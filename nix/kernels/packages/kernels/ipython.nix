{
  kernels,
  name,
  ...
} @ args: let
  inherit (args.inputs) cells;
  python = kernels.python.override cells.kernels.packages.poetryPackages;
in
  python {
    name = "python-with-threat-intelligence";
    displayName = "python with threat intelligence";
  }
