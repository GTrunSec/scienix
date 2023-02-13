{
  inputs,
  cell,
}: let
  inherit (inputs) std std-data-collection;
in {
  treefmt = std-data-collection.data.configs.treefmt {
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
