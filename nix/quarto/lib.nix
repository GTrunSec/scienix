{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells-lab._writers.lib) writeShellApplication;
in {
  mkEnv = {
    r ? (_: []),
    python ? (_: []),
    text ? "",
  }: let
    pythonEnv =
      nixpkgs.python3.buildEnv.override
      {
        extraLibs = with nixpkgs.python3Packages;
          [
            nbconvert
            ipykernel
            bash_kernel
            jupyter
          ]
          ++ (python nixpkgs.python3Packages);
      };
    rEnv = nixpkgs.rWrapper.override {
      packages = with nixpkgs.rPackages;
        [
          dplyr
          ggplot2
          lubridate
          readr
          rmarkdown
          ggrepel
          tidyr
        ]
        ++ (r nixpkgs.rPackages);
    };
    entrypoint = writeShellApplication {
      name = "tenzir-web";
      runtimeInputs = [rEnv nixpkgs.quarto pythonEnv];
      runtimeEnv = {
        QUARTO_R = "${rEnv}/bin/R";
      };
      inherit text;
    };
    shell = nixpkgs.mkShell {
      buildInputs = [rEnv nixpkgs.quarto pythonEnv];
    };
  in {
    inherit entrypoint shell;
  };
}
