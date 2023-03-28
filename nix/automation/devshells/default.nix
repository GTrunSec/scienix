{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {
      name = "Decentralized Data Science";

      imports = [
        inputs.std.std.devshellProfiles.default
        inputs.std-ext.automation.devshellProfiles.docs

        inputs.cells.julia.devshellProfiles.default
        inputs.cells.kernels.devshellProfiles.default
        inputs.cells.vast.devshellProfiles.default
        inputs.julia2nix.julia2nix.devshellProfiles.dev

        inputs.cells.ml.devshellProfiles.default
        inputs.cells.python.devshellProfiles.default
      ];

      commands = [
        {
          package = inputs.cells.shell.packages.nushell;
        }
        {
          package = inputs.cells.quarto.entrypoints.default;
        }
      ];

      nixago = [
        cell.nixago.treefmt
        cell.nixago.just
      ];

      packages = with nixpkgs; [
        sd
        inputs.cells.python.packages.poetryEnv
      ];
    };

    std = {
      name = "Standard Shell";
      imports = [
        inputs.std.std.devshellProfiles.default
      ];
    };

    generator = {
      imports = [inputs.cells.example.devshellProfiles.default];
      nixago = [] ++ l.attrValues inputs.cells.vast.nixago;
      devshell.startup.cpSchemas = l.stringsWithDeps.noDepEntry ''
        rsync --chmod 0777 -avzh $PRJ_ROOT/nix/julia/packages/*.toml --exclude 'julia2nix.toml' modules/playground/
        rsync --chmod 0777 -avzh $PRJ_ROOT/nix/python/packages/*.{toml,lock} modules/playground/
      '';
    };

    doc = {
      name = "Documentation";
      commands = [
        {
          package = inputs.cells.quarto.entrypoints.mkQuarto;
          help = "Build the documentation with quarto";
        }
      ];
      imports = [
        inputs.std-ext.automation.devshellProfiles.docs
      ];
      packages = [inputs.cells.kernels.packages.jupyenv];
    };

    tullia = {
      imports = [
        inputs.dataflow2nix.tullia.devshellProfiles.default
      ];
      commands = [
        {
          package = inputs.nixpkgs.podman;
        }
        {
          package = inputs.nixpkgs.nsjail;
        }
      ];
    };
    opencti = {
      commands = [
        {package = inputs.cells.python.packages.mkPoetryOpenCTI;}
      ];
    };
  }
