{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    latest.url = "github:NixOS/nixpkgs";

    cells-lab.url = "github:GTrunSec/cells-lab";
    cells-lab.inputs.nixpkgs.follows = "nixpkgs";

    std.follows = "cells-lab/std";

    n2c.url = "github:nlewo/nix2container";
    n2c.inputs.nixpkgs.follows = "cells-lab/std/nixpkgs";
  };
  inputs = {
    julia2nix.url = "github:JuliaCN/Julia2Nix.jl";
    julia2nix.inputs.nixpkgs.follows = "nixpkgs";

    jupyterWith.url = "github:tweag/jupyterWith";
    # jupyterWith.url = "/home/gtrun/ghq/github.com/GTrunSec/jupyterWith";

    matrix-attack-data.url = "github:GTrunSec/matrix-attack-data";
    matrix-attack-data.inputs.nixpkgs.follows = "nixpkgs";

    dataflow2nix.url = "github:GTrunSec/dataflow2nix";
    dataflow2nix.inputs.nixpkgs.follows = "nixpkgs";
    dataflow2nix.inputs.cells-lab.follows = "cells-lab";

    tullia.url = "github:input-output-hk/tullia";
    tullia.inputs.nixpkgs.follows = "nixpkgs";
    # tullia.url = "/home/gtrun/ghq/github.com/input-output-hk/tullia";

    users.follows = "cells-lab/std/blank";
  };

  outputs = {
    std,
    tullia,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./nix;
      cellBlocks = with std.blockTypes;
        [
          (installables "packages")

          (functions "devshellProfiles")
          (devshells "devshells")

          (runnables "entrypoints")

          (functions "lib")

          (data "cargoMakeJobs")

          (functions "packages")

          (functions "overlays")

          (data "config")

          (nixago "nixago")

          (tullia.tasks "pipelines")
          (functions "actions")
        ]
        ++ [
          (containers "containers")
        ];
    } {
      devShells = inputs.std.harvest inputs.self ["_automation" "devshells"];
      packages = inputs.std.harvest inputs.self [
        ["julia" "packages"]
        ["python" "packages"]
      ];
    } (tullia.fromStd {
      tasks = std.harvest inputs.self [["julia" "pipelines"]];
      actions = std.harvest inputs.self [["julia" "actions"]];
    }) {
      templates = {
        tenzir = {
          description = "Tenzir's nix template for new projects";
          path = ./users/tenzir;
        };
      };
    };
}
