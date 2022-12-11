{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeClicheApplication;
  inherit (inputs.dataflow2nix.prefect.lib) mkPrefectJob;
  inherit (inputs.cells.python.lib) nixpkgs;
in {
  d = mkPrefectJob {
    providers = {
      jupyter = true;
      aws = false;
    };
    extraLibs = with nixpkgs.python3Packages; [];
    text = ''
      python ${./d.py}
    '';
  };
}
