{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.writers.lib) writeShellApplication;
in {
  mkAutoCommit = path: branch:
    writeShellApplication {
      name = "mkAutoCommit";
      runtimeInputs = [inputs.cells.common.lib.__inputs__.nixpkgs-hardenedlinux.packages.gptcommit];
      text = ''
        gptcommit install
        cd "$PRJ_ROOT"/modules/${path}
        treefmt .
        git add .
        git commit --no-edit
        git push ${branch} --no-verify
        gptcommit uninstall
      '';
    };
}
