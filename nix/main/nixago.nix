{
  inputs,
  cell,
}: let
  inherit (inputs) std;
in {
  mdbook = std.presets.nixago.mdbook {
    configData = {
      book.title = "Data Science Threat Intelligence";
    };
  };
  treefmt = std.presets.nixago.treefmt {
    configData.formatter.nix = {
      excludes = [
        "generated.nix"
      ];
    };
    configData.formatter.prettier = {
      excludes = [
        "conf/*"
        "data/*"
        "Manifest.toml"
        "Project.toml"
      ];
    };
  };
  just = std.std.nixago.just {
    configData = {
      tasks = import ./tasks.nix;
    };
  };
}
