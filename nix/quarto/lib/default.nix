{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
in {
  mkEnv = args': import ./mkEnv.nix args args';
}
