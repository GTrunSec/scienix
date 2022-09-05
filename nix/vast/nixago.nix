{
  inputs,
  cell,
}: let
  inherit (inputs) std nixpkgs;
  inherit (std) dmerge;
  inherit (inputs.cells.main.library) __inputs__;
  inherit (__inputs__) vast2nix;
  inherit (nixpkgs) lib;

in
  builtins.mapAttrs (_: std.std.lib.mkNixago) {
    vast = {
      configData = vast2nix.vast.config.mkConfig (std.dmerge.merge (vast2nix.vast.config.default {
        dataDir = "./vast.db";
      }) {
        schema-dirs = [] ++ (lib.attrValues inputs.matrix-attack-data.vast.schemas);
        # settings
      });
      output = "conf/vast/vast.yaml";
      format = "yaml";
      hook.mode = "copy";
    };
    vast-integration = {
      configData = vast2nix.vast.config.integration {};
      output = "conf/vast/vast-integration.yaml";
      format = "yaml";
      hook.mode = "copy";
    };
    vast-cargo-make = {
      configData = cell.cargoMakeJobs.vast;
      output = "conf/vast/cargo-make.toml";
      format = "toml";
      hook.mode = "copy";
    };
  }
