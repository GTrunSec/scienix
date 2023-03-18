{
  inputs,
  cell,
}: {
  poetryEnvArgs = nixpkgs: {
    projectDir = ./packages;
    extraPackages = ps:
      with ps;
        [
          python-lsp-server
        ]
        ++ python-lsp-server.passthru.optional-dependencies.all;
    groups = [];
    overrides = nixpkgs.poetry2nix.overrides.withDefaults (import ./packages/overrides.nix);
    preferWheels = true;
  };
}
