{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in {
  default = inputs.cells-lab.main.library.mergeDevShell {
    mkShell = nixpkgs.mkShell {
      nativeBuildInputs = with nixpkgs; [openssl];
      buildInputs = with nixpkgs; [
        cell.packages.poetryPython
      ];
    };

    devshell = std.std.lib.mkShell {
      name = "Data Science Threat Intelligence";

      std.adr.enable = false;

      imports = [
        inputs.std.std.devshellProfiles.default
        inputs.cells.julia.devshellProfiles.default
        inputs.cells.kernels.devshellProfiles.default
        inputs.julia2nix.julia2nix.devshellProfiles.dev
      ];

      commands = [
        {
          name = "jupyter";
          command = "${inputs.cells.kernels.packages.jupyterEnvironment}/bin/jupyter $@";
        }
      ];

      nixago = [
        inputs.cells-lab.main.nixago.treefmt
      ] ++ l.attrValues inputs.cells.vast.nixago;
    };
  };
}
