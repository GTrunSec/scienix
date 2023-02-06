{
  kernels,
  name,
  ...
} @ args: let
  nixpkgs = args.inputs.nixpkgs;
in
  kernels.bash {
    displayName = name;
    extraRuntimePackages = with nixpkgs; [
      nix
      git
      args.inputs.cells.shell.entrypoints.nu
      args.inputs.cells.vast.packages.vast-bin
    ];
  }
