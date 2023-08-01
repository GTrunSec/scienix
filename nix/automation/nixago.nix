{ inputs, cell }:
let
  inherit (inputs) std-ext;
in
{
  treefmt = std-ext.preset.nixago.configs.treefmt {
    data.formatter.nix = {
      excludes = [
        "generated.nix"
        "./modules/*"
      ];
    };
    data.formatter.prettier = {
      excludes = [
        "conf/*"
        "data/*"
        "docs/*"
        "julia2nix.toml"
        "Manifest.toml"
        "Project.toml"
      ];
    };
  };
  just = std.lib.cfg.just {
    data = {
      tasks = import ./just.nix;
    };
  };
}
