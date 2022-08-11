{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    cells-lab.url = "github:GTrunSec/cells-lab";

    std.follows = "cells-lab/std";
    yants.follows = "cells-lab/yants";
    data-merge.follows = "cells-lab/data-merge";
  };
  inputs = {
    julia2nix.url = "github:JuliaCN/Julia2Nix.jl";
    julia2nix.inputs.nixpkgs.follows = "nixpkgs";

    jupyterWith.url = "github:tweag/jupyterWith/next";
    jupyterWith.inputs.nixpkgs.follows = "nixpkgs";

    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {std, ...} @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./nix;
      organelles = [
        (std.installables "packages")

        (std.functions "devshellProfiles")
        (std.devshells "devshells")

        (std.runnables "entrypoints")

        (std.functions "library")

        (std.functions "packages")

        (std.functions "overlays")

        (std.nixago "nixago")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["main" "devshells"];
      packages = inputs.std.harvest inputs.self ["main" "packages"];
    };
}
