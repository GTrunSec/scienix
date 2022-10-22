{
  inputs,
  cell,
}: let
  inherit (cell) lib cargoMakeJobs;
  inherit (inputs.cells._common.lib) writeConf;
  inherit (inputs.cells-lab._flow.lib) makeCargoMakeFlow;
in {
  flow = makeCargoMakeFlow {
    source = cell.nixago.vast-cargo-make.configFile;
    # "all"
    args = ["smtp-url"];
  };
}
