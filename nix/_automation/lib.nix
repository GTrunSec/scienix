{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std self;
  inherit (inputs.cells-lab.main.lib) callFlake;
  l = nixpkgs.lib // builtins;

  __inputs__ = callFlake "${(std.incl self [(self + /lock)])}/lock" {
    nixpkgs.locked = inputs.nixpkgs.sourceInfo;
  };
in {
  inherit __inputs__ l;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    __inputs__.poetry2nix.overlay
  ];
}
