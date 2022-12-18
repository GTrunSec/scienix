{
  inputs,
  cell,
}: let
  inherit (inputs) std;
in {
  default = std.lib.ops.mkDevOCI {
    name = "ghcr.io/gtrunsec/data-science-threat-intelligence";
    tag = "latest";
    devshell = cell.devshells.default;
    labels = {
      title = "data-science-threat-intelligence";
      version = "latest";
      url = "https://github.com/GTrunSec/data-science-threat-intelligence/nix/data";
      source = "https://github.com/GTrunSec/data-science-threat-intelligence/nix/data/devshells";
      description = ''
        A preconfiged devshell for analyzing threat-intelligence
      '';
    };
  };
}
