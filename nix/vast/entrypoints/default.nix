{
  inputs,
  cell,
}: let
  inherit (cell) library cargoMakeJobs;
  inherit (inputs.cells.main.library) writeConf;
  inherit (inputs.cells-lab._flow.library) makeCargoMakeFlow;
in {
  flow = makeCargoMakeFlow {
    source = (writeConf cargoMakeJobs.vast-integration "toml");
    # "all"
    args = ["smtp-url"];
  };
}
