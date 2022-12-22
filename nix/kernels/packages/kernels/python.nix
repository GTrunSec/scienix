{
  kernels,
  name,
  ...
} @ args: let
  inherit (args.inputs) cells;
in
  kernels.python ((cells.python.lib.poetryAttrs {
      jupyterWith = true;
    })
    // {
      inherit name;
      displayName = name;
    })
