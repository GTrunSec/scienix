{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
  inherit (cell) packages;
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
in {
  nu = writeShellApplication {
    name = "nu";
    runtimeInputs = [packages.nushell];
    text = ''
      nu -c 'register ${l.getExe packages.nu-plugin-regex}' && \
      nu -c 'register ${l.getExe packages.nu-plugin-from-parquet}'
      nu "$@"
    '';
  };
}
