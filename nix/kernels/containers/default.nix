{
  inputs,
  cell,
}: let
  inherit (inputs) std;
in {
  dev = std.lib.ops.mkDevOCI {
    name = "docker.io/jupyter-dev";
    tag = "latest";
    devshell = inputs.cells.automation.devshells.default;
    labels = {
      title = "jupyter-dev";
      version = "latest";
      url = "https://github.com/GTrunSec/data-science-threat-intelligence";
      source = "https://github.com/GTrunSec/data-science-threat-intelligence/tree/main/nix/kernels";
      description = ''
        A prepackaged container for running jupyterlab
      '';
    };
  };
}
