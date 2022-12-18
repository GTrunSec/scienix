{
  inputs,
  cell,
}: let
  inherit (inputs) std;
in {
  dev = std.lib.ops.mkDevOCI {
    name = "ghcr.io/gtrunsec/desci.quarto";
    tag = "latest";
    devshell = cell.devshells.default;
    labels = {
      title = "quarto-dev";
      version = "latest";
      url = "https://quarto.org";
      source = "https://github.com/DeSci/nix/quarto";
      description = ''
        A prepackaged container for running quarto
      '';
    };
  };
}
