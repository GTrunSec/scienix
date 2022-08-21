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
      "phishing.data" = builtins.mapAttrs (n: v: v.schemas.data.validation.type) config.phishing-features;
    };
    fixConfig = {};
  }
