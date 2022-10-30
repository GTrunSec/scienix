{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    latest.url = "github:NixOS/nixpkgs";

    cells-lab.url = "github:GTrunSec/cells-lab";
    std.follows = "cells-lab/std";
    std.inputs.n2c.follows = "cells-lab/std";

    n2c.url = "github:nlewo/nix2container";
    n2c.inputs.nixpkgs.follows = "cells-lab/std/nixpkgs";
  };
  inputs = {
    julia2nix.url = "github:JuliaCN/Julia2Nix.jl";
    julia2nix.inputs.nixpkgs.follows = "nixpkgs";

    jupyterWith.url = "github:tweag/jupyterWith/?ref=refs/pull/331/head";
    # jupyterWith.url = "/home/gtrun/ghq/github.com/GTrunSec/jupyterWith";

    matrix-attack-data.url = "github:GTrunSec/matrix-attack-data";
    matrix-attack-data.inputs.nixpkgs.follows = "nixpkgs";

    dataflow2nix.url = "github:GTrunSec/dataflow2nix";
    dataflow2nix.inputs.nixpkgs.follows = "nixpkgs";

    tullia.url = "github:input-output-hk/tullia?ref=refs/pull/9/head";
    # tullia.url = "/home/gtrun/ghq/github.com/input-output-hk/tullia";

    users.follows = "cells-lab/std/blank";
  };

  outputs = {std, ...} @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./nix;
      cellBlocks = with std.blockTypes; [
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

        (containers "containers")

        (functions "pipelines")
        (functions "actions")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["_automation" "devshells"];
      packages = inputs.std.harvest inputs.self [
        ["julia" "packages"]
        ["python" "packages"]
      ];
    } (inputs.tullia.fromStd {
      tasks = inputs.std.harvest inputs.self [["julia" "pipelines"]];
      actions = inputs.std.harvest inputs.self [["julia" "actions"]];
    }) {
      templates = {
        tenzir = {
          description = "Tenzir's nix template for new projects";
          path = ./users/tenzir;
        };
      };
    };
}
