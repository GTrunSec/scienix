{
  inputs,
  cell,
}: let
  inherit (inputs.cells._common.lib) __inputs__;
  inherit (__inputs__) vast2nix;
  inherit (inputs) nixpkgs;
in {
  default = {
    commands = [
      {
        package = __inputs__.vast2nix.packages.${nixpkgs.system}.vast-bin;
        help = __inputs__.vast2nix.packages.${nixpkgs.system}.vast-latest.meta.description;
      }
      {
        package = vast2nix.vast.packages.vast-integration;
      }
    ];
  };
}
