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
      buildInputs = with nixpkgs; [inputs.cells.kernels.packages.jupyterEnvironment];
    };

    devshell = std.std.lib.mkShell {
      name = "Data Science Threat Intelligence";

      std.adr.enable = false;

      imports = [
        inputs.std.std.devshellProfiles.default
        inputs.cells.julia.devshellProfiles.default
      ];
      nixago = [
        inputs.cells-lab.main.nixago.treefmt
        cell.nixago.mdbook
      ] ++ l.attrValues inputs.cells.vast.nixago;
    };
  };
}
