{
  inputs,
  cell,
}: let
  inherit (cell) library cargoMakeJobs;
  inherit (inputs.cells.main.library) writeConf;
  inherit (inputs.cells-lab._flow.library) makeCargoMakeFlow;
in {
  flow = makeCargoMakeFlow {
    source = cell.nixago.vast-cargo-make.configFile;
    # "all"
    args = ["smtp-url"];
  };
}
