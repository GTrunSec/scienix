{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    std-ext.url = "github:GTrunSec/std-ext";
    # cells-lab.url = "/home/guangtao/ghq/github.com/GTrunSec/cells-lab";
    std-ext.inputs.std.follows = "std";
    std-ext.inputs.nixpkgs.follows = "nixpkgs";

    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "std-ext/nixpkgs";
    std.inputs.n2c.follows = "n2c";
    std-data-collection.follows = "std-ext/std-data-collection";

    n2c.url = "github:nlewo/nix2container";
    n2c.inputs.nixpkgs.follows = "nixpkgs";

    std-utils.url = "github:jmgilman/nix-utils";
    std-utils.inputs.nixpkgs.follows = "nixpkgs";
    std-utils.inputs.std.follows = "std";
  };

  inputs = {
    julia2nix.url = "github:JuliaCN/Julia2Nix.jl";
    julia2nix.inputs.nixpkgs.follows = "nixpkgs";

    # jupyenv.url = "github:tweag/jupyenv";
    # jupyenv.url = "/home/guangtao/ghq/github.com/tweag/jupyterWith";
    jupyenv.url = "github:gtrunsec/jupyterWith/dev";
    jupyenv.inputs.nixpkgs.follows = "nixpkgs";

    dataflow2nix.url = "github:GTrunSec/dataflow2nix";
    dataflow2nix.inputs.nixpkgs.follows = "nixpkgs";

    # tullia.url = "github:input-output-hk/tullia";
    # # tullia.url = "/home/guangtao/ghq/github.com/input-output-hk/tullia";
    # tullia.inputs.std.follows = "std";
    # tullia.inputs.nixpkgs.follows = "nixpkgs";
    # tullia.inputs.nix2container.follows = "n2c";
    # tullia.inputs.nix-nomad.follows = "nix-nomad";
    # nix-nomad.url = "github:tristanpemble/nix-nomad";
  };

  outputs = {
    std,
    self,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./nix;
      cellBlocks = with std.blockTypes;
        [
          (functions "devshellProfiles")

          (devshells "devshells")

          (runnables "entrypoints")

          (functions "lib")

          (installables "packages" {ci.build = true;})

          (functions "overlays")

          (data "config")

          (nixago "nixago")

          # (tullia.tasks "pipelines")
          (functions "pipelines")
          (functions "actions")

          # modules
          (data "jupyenvModules")

          (data "composeJobs")
          (containers "oci-images")
          (runnables "operators")

          # nushell scripts
          (installables "nu")
        ]
        ++ [
          (containers "containers" {ci.publish = true;})
        ];
    } {
      devShells = inputs.std.harvest inputs.self ["automation" "devshells"];
      packages = inputs.std.harvest inputs.self [
        ["julia" "packages"]
        ["python" "packages"]
      ];
    } {
      process-compose =
        inputs.std-ext.lib.mkProcessCompose ["composeJobs" "oci-images"]
        self {
          log_location = "$HOME/.cache/process-compose.log";
        };
    } # (tullia.fromStd {
    #   tasks = std.harvest inputs.self [["julia" "pipelines"]];
    #   actions = std.harvest inputs.self [["julia" "actions"]];
    # })
    {
      templates = {
        tenzir = {
          description = "Tenzir's nix template for new projects";
          path = ./users/tenzir;
        };
      };
    };
  nixConfig = {
    extra-substituters = [
      "https://gtrunsec.cachix.org"
    ];
    extra-trusted-public-keys = [
      "gtrunsec.cachix.org-1:hqyEeSuO8HAm6xuChKrTJpLPpHUKtdjh4o/MRmcMQIo="
    ];
  };
}
