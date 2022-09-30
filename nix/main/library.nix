{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std self;
  inherit (inputs.cells-lab.main.library) callFlake;
  l = nixpkgs.lib // builtins;

  __inputs__ = callFlake "${(std.incl self [(self + /lock)])}/lock" {
    nixpkgs.locked = inputs.nixpkgs-lock.sourceInfo;
  };
in {
  inherit __inputs__ l;
}
