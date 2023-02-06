{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
in {
  mkQuarto = import ./mkQuarto.nix args;
}
