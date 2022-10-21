{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    latest.url = "github:NixOS/nixpkgs";

    cells-lab.url = "github:GTrunSec/cells-lab";
    std.follows = "cells-lab/std";
  };
  inputs = {
    julia2nix.url = "github:JuliaCN/Julia2Nix.jl";
    julia2nix.inputs.nixpkgs.follows = "nixpkgs";

    jupyterWith.url = "github:gtrunsec/jupyterWith/dev";
    # jupyterWith.url = "/home/gtrun/ghq/github.com/GTrunSec/jupyterWith";

    matrix-attack-data.url = "github:GTrunSec/matrix-attack-data";
    matrix-attack-data.inputs.nixpkgs.follows = "nixpkgs";

    dataflow2nix.url = "github:GTrunSec/dataflow2nix";
    dataflow2nix.inputs.nixpkgs.follows = "nixpkgs";

    tullia.follows = "dataflow2nix/tullia";

    users.follows = "cells-lab/std/blank";
  };

  outputs = {std, ...} @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./nix;
      cellBlocks = [
        (std.blockTypes.installables "packages")

        (std.blockTypes.functions "devshellProfiles")
        (std.blockTypes.devshells "devshells")

        (std.blockTypes.runnables "entrypoints")

        (std.blockTypes.functions "lib")

        (std.blockTypes.data "cargoMakeJobs")

        (std.blockTypes.functions "packages")

        (std.blockTypes.functions "overlays")

        (std.blockTypes.data "config")

        (std.blockTypes.nixago "nixago")

        (std.blockTypes.containers "containers")

        (std.blockTypes.functions "task")
        (std.blockTypes.functions "action")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["_automation" "devshells"];
      packages = inputs.std.harvest inputs.self [
        ["julia" "packages"]
      ];
    } (inputs.tullia.fromStd {
      tasks = inputs.std.harvest inputs.self [["julia" "task"]];
      actions = inputs.std.harvest inputs.self [["julia" "action"]];
    }) {
      templates = {
        tenzir = {
          description = "Tenzir's nix template for new projects";
          path = ./users/tenzir;
        };
      };
    };
}
