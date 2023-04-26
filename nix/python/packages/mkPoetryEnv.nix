{
  inputs,
  cell,
}: {
  groups ? [],
  cudaSupport ? false,
  ignoreVersion ? false,
  ...
} @ args: let
  inherit (cell.lib) nixpkgs;
  l = nixpkgs.lib // builtins;
in
  (nixpkgs.poetry2nix.mkPoetryEnv {
      projectDir = ./.;
      # python = nixpkgs.python39;
      extraPackages = ps:
        with ps;
          [
            pandas
            seaborn
            # (ps.pytorch.override {inherit cudaSupport;})
            # tensorflow
            matplotlib
            numpy
            # nixpkgs.python3Packages.fastai
            python-lsp-server
          ]
          ++ python-lsp-server.passthru.optional-dependencies.all;
      overrides = nixpkgs.poetry2nix.overrides.withDefaults (import ./overrides.nix);
      inherit groups;
      preferWheels = true;
    }
    // (l.removeAttrs args ["ignoreCollisions"]))
  .override (old: {ignoreCollisions = true;})
