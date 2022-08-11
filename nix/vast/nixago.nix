{
  inputs,
  cell,
}: let
  inherit (inputs) std;
  inherit (inputs.cells.main.library) __inputs__;
  inherit (__inputs__) vast2nix nixpkgs;
in
  builtins.mapAttrs (_: std.std.lib.mkNixago) {
    vast = {
      configData = vast2nix.vast.config.default {};
      output = "conf/tenzir-vast.yaml";
      format = "yaml";
      hook.mode = "copy"; # already useful before entering the devshell
    };
    vast-integration = {
      configData = vast2nix.vast.config.integration {};
      output = "conf/tenzir-vast-integration.yaml";
      format = "yaml";
      hook.mode = "copy"; # already useful before entering the devshell
    };
  }
