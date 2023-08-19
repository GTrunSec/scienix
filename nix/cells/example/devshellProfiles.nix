{ inputs, cell }:
let
  l = inputs.nixpkgs.lib // builtins;
in
{
  default = {
    nixago = l.attrValues cell.nixago;
  };
}
