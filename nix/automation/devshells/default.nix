{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in {
  default = std.lib.dev.mkShell {
    name = "Decentralized Data Science";

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
      {
        package = nixpkgs.nushell;
      }
      {
        package = inputs.cells.python.packages.mkPoetryEnv;
      }
    ];

    # env = let
    #   pythonPath = with inputs.cells.python.lib.nixpkgs; inputs.cells.python.lib.nixpkgs.python3.pkgs.makePythonPath [
    #     python3.pkgs.fastai
    #     python3.pkgs.torch
    #   ];
    #   in [
    #   {
    #     name = "PYTHONPATH";
    #     value = "${pythonPath}";
    #   }
    # ];

    nixago = [
      cell.nixago.treefmt
      cell.nixago.just
      cell.nixago.mdbook
    ];
  };

  generator = std.lib.dev.mkShell {
    nixago = [] ++ l.attrValues inputs.cells.vast.nixago;
  };

  doc = {...}: {
    name = "Org Roam Documentation";
    imports = [
      inputs.cells-lab.automation.devshellProfiles.docs
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
  opencti = std.lib.dev.mkShell {
    commands = [
      {package = inputs.cells.python.packages.mkPoetryOpenCTI;}
    ];
  };
}
