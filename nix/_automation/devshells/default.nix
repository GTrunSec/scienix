{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
  inherit (cell.lib) __inputs__;
in {
  default = std.lib.dev.mkShell {
    name = "Data Science Threat Intelligence";

    imports = [
      inputs.std.std.devshellProfiles.default
      inputs.cells.julia.devshellProfiles.default
      inputs.cells.kernels.devshellProfiles.default
      inputs.cells.vast.devshellProfiles.default
      inputs.julia2nix.julia2nix.devshellProfiles.dev

      inputs.dataflow2nix.tullia.devshellProfiles.default
    ];

    commands = [
      {
        package = inputs.latest.legacyPackages.${nixpkgs.system}.poetry;
      }
    ];

    nixago =
      [
        cell.nixago.treefmt
        cell.nixago.just
        cell.nixago.mdbook
      ]
      ++ l.attrValues inputs.cells.vast.nixago;
  };

  doc = std.lib.dev.mkShell {
    nixago = [
      cell.nixago.mdbook
    ];
  };
  tullia = std.lib.dev.mkShell {
    imports = [
      inputs.dataflow2nix.tullia.devshellProfiles.default
    ];
    commands = [
      {
        package = inputs.nixpkgs.faketty;
      }
      {
        package = inputs.nixpkgs.podman;
      }
      {
        package = inputs.nixpkgs.nsjail;
      }
    ];
  };
}
