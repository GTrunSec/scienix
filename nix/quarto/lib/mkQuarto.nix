{
  inputs,
  cell,
}: let
  nixpkgs = inputs.nixpkgs.appendOverlays [cell.overlays.default];
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
  l = inputs.nixpkgs.lib // builtins;
in
  {
    text ? "",
    runtimeInputs ? [],
    runtimeEnv ? {},
    kernels ? {},
    package ? nixpkgs.quarto,
  }: let
    # pythonEnv = let
    #   env = nixpkgs.python3.withPackages (ps:
    #     with ps;
    #       [
    #         jupyter
    #         ipython
    #       ]
    #       ++ (python ps));
    # in
    #   nixpkgs.runCommand "python-env" {
    #     buildInputs = [nixpkgs.makeWrapper];
    #   } ''
    #     mkdir -p $out/bin
    #     for i in ${env}/bin/*; do
    #     filename=$(basename $i)
    #     ln -s ${env}/bin/$filename $out/bin/$filename
    #     wrapProgram $out/bin/$filename \
    #       --set JUPYTER_PATH ${l.concatStringsSep ":" (l.attrValues kernels)}
    #     done
    #   '';
    # rEnv = nixpkgs.rWrapper.override {
    #   packages = with nixpkgs.rPackages;
    #     [rmarkdown]
    #     ++ (r nixpkgs.rPackages);
    # };
  in
    (writeShellApplication {
      name = "quarto";
      runtimeInputs =
        [
          package
          nixpkgs.rsync
        ]
        ++ runtimeInputs;
      runtimeEnv =
        {
          # QUARTO_R = "${rEnv}/bin/R";
        }
        // runtimeEnv;
      inherit text;
    })
    .overrideAttrs (old: {
      passthru = {
        quarto = nixpkgs.quarto;
      };
    })
