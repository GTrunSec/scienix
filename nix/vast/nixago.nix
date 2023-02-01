{
  inputs,
  cell,
}: let
  inherit (inputs) std nixpkgs;
  inherit (std) dmerge;
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (__inputs__) vast2nix;
  inherit (nixpkgs) lib;
in
  builtins.mapAttrs (_: std.lib.dev.mkNixago) {
    vast = {
      configData =
        vast2nix.vast.lib.mkConfig {
          dataDir = "./vast.db";
        } {
          schema-dirs = [] ++ (lib.attrValues inputs.matrix-attack-data.vast.schemas);
          # settings
        };
      output = "conf/vast/vast.yaml";
      format = "yaml";
      hook.mode = "copy";
    };
    vast-integration = {
      configData = vast2nix.vast.lib.mkIntegration {};
      output = "conf/vast/vast-integration.yaml";
      format = "yaml";
      hook.mode = "copy";
    };
  }
