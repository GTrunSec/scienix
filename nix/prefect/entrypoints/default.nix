{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeClicheApplication;
  inherit (inputs.dataflow2nix.prefect.lib) mkPrefectJob;
  inherit (inputs.cells.python.lib) nixpkgs;
in {
  d = mkPrefectJob {
    extraPackages = with nixpkgs.python3Packages; [];
    text = ''
      python ${./d.py}
    '';
  };
}
