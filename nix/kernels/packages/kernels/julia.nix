{
  kernels,
  name,
  ...
} @ args: let
in
  kernels.julia {
    displayName = name;
    pkgs = args.inputs.nixpkgs;
    julia-bin = args.inputs.julia2nix.packages.${args.nixpkgs.system}.julia_18-bin;
    activateDir = "/home/gtrun/ghq/github.com/GTrunSec/DeSci/playground";
  }
