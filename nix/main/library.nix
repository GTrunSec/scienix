{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std self;
  inherit (inputs.cells-lab._writers.library) writeConfiguration;

  __inputs__ =
    (std.deSystemize nixpkgs.system
      (import "${(std.incl self [(self + /lock)])}/lock").inputs)
    // inputs;

  writeConf = source: name: format:
    (writeConfiguration {
      language = "nix";
      inherit source name format;
    })
    .data;

in {
  inherit __inputs__;

  writeConf = source: format:
    (writeConfiguration {
      language = "nix";
      name = "nix2Conf";
      inherit source format;
    })
    .data;

}
