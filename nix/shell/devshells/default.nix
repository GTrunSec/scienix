{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in {
  default = std.lib.dev.mkShell {
    name = "Data Science Threat Intelligence";

    imports = [
      cell.devshellProfiles.toolchain
    ];

    commands = [
      {
        package = nixpkgs.nushell;
      }
    ];
  };
}
