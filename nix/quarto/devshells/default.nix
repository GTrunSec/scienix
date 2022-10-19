{
  inputs,
  cell,
}: let
  inherit (inputs) std nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: let
      pythonEnv =
        nixpkgs.python3.buildEnv.override
        {
          extraLibs = with nixpkgs.python3Packages; [
            nbconvert
            ipykernel
            bash_kernel
            jupyter
          ];
        };
      rEnv = nixpkgs.rWrapper.override {
        packages = with nixpkgs.rPackages; [
          dplyr
          ggplot2
          lubridate
          readr
          rmarkdown
          ggrepel
          tidyr
        ];
      };
    in {
      name = "quarto-devshell";

      commands = [
        {
          package = nixpkgs.quarto;
        }
      ];

      packages = [
        rEnv
        pythonEnv
        nixpkgs.which
      ];

      env = [
        {
          name = "QUARTO_R";
          value = "${rEnv}/bin/R";
        }
        {
          name = "QUARTO_PYTHON";
          value = "${pythonEnv}/bin/python";
        }
      ];
    };
  }
