{
  inputs,
  cell,
}: let
  inherit (cell) lib cargoMakeJobs;
  inherit (inputs.cells.common.lib) writeConf;
  inherit (inputs.cells-lab.workflows.lib) mkCargoMake;
in {
  flow = mkCargoMake {
    source = cell.nixago.vast-cargo-make.configFile;
    # "all"
    args = ["smtp-url"];
  };
}
