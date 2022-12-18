{
  inputs,
  cell,
}: let
  inherit (inputs) std;
  inherit (std.lib.ops) mkDevOCI mkSetup;

  l = inputs.nixpkgs.lib // builtins;
in {
  default = mkDevOCI {
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
    setup = [
      (mkSetup "nushell-config" [
          {
            path = "/home/user/.config/nushell";
            mode = "0777";
          }
        ] ''
          mkdir -p $out/home/user/.config/nushell
          ${l.getExe cell.entrypoints.nu} -c 'echo hello'
        '')
    ];
  };
}
