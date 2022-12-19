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
    ];
  }
