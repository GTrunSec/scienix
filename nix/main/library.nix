{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std self;
  __inputs__ =
    (std.deSystemize nixpkgs.system
      (import "${(std.incl self [(self + /lock)])}/lock").inputs)
    // inputs;
in {
  inherit __inputs__;
}
