{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    std-ext.url = "github:GTrunSec/std-ext";
    std-ext.inputs.std.follows = "std";
    std-ext.inputs.nixpkgs.follows = "nixpkgs";
    flops.follows = "std-ext/flops";

    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "std-ext/nixpkgs";
    std.inputs.devshell.follows = "std-ext/devshell";
    std.inputs.nixago.follows = "std-ext/nixago";
    std.inputs.n2c.follows = "n2c";

    n2c.url = "github:nlewo/nix2container";
    n2c.inputs.nixpkgs.follows = "nixpkgs";
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
  };

  outputs =
    {
      std,
      self,
      flake-parts,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      __inputs__ =
        removeAttrs (inputs.std-ext.inputs.flops.inputs.call-flake ./nix/lock).inputs
          [ "nixpkgs" ];
    in
    flake-parts.lib.mkFlake { inputs = inputs // __inputs__; } {
      inherit systems;
      flake = {
        devShells = inputs.std.harvest inputs.self [ [
          "dev"
          "devshells"
        ] ];
      };
      imports = [ inputs.std.flakeModule ];
      std.grow.cellsFrom = ./nix/cells;
      std.grow.cellBlocks =
        with std.blockTypes;
        [
          (functions "devshellProfiles")

          (devshells "devshells")

          (runnables "entrypoints")
          (runnables "scripts")
          (runnables "tasks")

          (functions "lib")

          (installables "packages" { ci.build = true; })

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
        ++ [ (containers "containers" { ci.publish = true; }) ]
      ;
    };
  # {
  #   devShells = inputs.std.harvest inputs.self [
  #     "dev"
  #     "devshells"
  #   ];
  #   packages = inputs.std.harvest inputs.self [
  #     [
  #       "julia"
  #       "packages"
  #     ]
  #     [
  #       "python"
  #       "packages"
  #     ]
  #   ];
  # };
  nixConfig = {
    extra-substituters = [ "https://gtrunsec.cachix.org" ];
    extra-trusted-public-keys = [
      "gtrunsec.cachix.org-1:hqyEeSuO8HAm6xuChKrTJpLPpHUKtdjh4o/MRmcMQIo="
    ];
  };
}
