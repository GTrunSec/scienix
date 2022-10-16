{
  inputs,
  cell,
}: let
  inherit (inputs.cells._main.lib) __inputs__;
  inherit (__inputs__) vast2nix nixpkgs;
in {
  default = {
    commands = [
      {
        package = vast2nix.vast.packages.vast-integration;
      }
    ];
  };
}
