{
  inputs,
  cell,
}: let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.vast2nix.schemas) library;
  inherit (inputs.cells.schemas) config;
in
  library.writeVastSchema {
    config = {
      "phishing.result" = builtins.mapAttrs (n: v: v.type) (config.phishing-url-result.properties);
    };
    fixConfig = {};
  }
