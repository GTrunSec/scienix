{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeClicheApplication;
in {
  inherit (inputs.cells.utils.entrypoints) polars;
  inherit (inputs.cells.julia.entrypoints) cli;
}
