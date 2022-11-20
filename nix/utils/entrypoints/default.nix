{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeClicheApplication;
  inherit (inputs.cells.python.lib) nixpkgs;
in {
  polars = writeClicheApplication {
    name = "polars";
    path = ./polars;
    inherit nixpkgs;
    runtimeInputs = [];
    libraries = ps: [ps.polars];
  };
}
