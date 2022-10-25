{
  cell,
  inputs,
}: let
  cmd = type: text: {
    command = {inherit type text;};
  };
in {
  julia = {...}:
    cmd "shell" "julia --version"
    // {dependencies = [cell.packages.julia-wrapped];};

  jnumpy = {pkgs, ...}:
    cmd "shell" ''
      echo "$PATH" | tr : "\n"
      git clone https://github.com/GTrunSec/data-science-threat-intelligence
      cd data-science-threat-intelligence
      nix build -Lv .#packages.x86_64-linux.jnumpy
    ''
    // {
      preset.nix.enable = true;
      memory = 2000;
    };

  nix-build = {config, ...}: {
    command.text = "nix build";
    memory = 4 * 1024;
    nsjail.mount."/tmp".options.size = 8096;
    preset.nix.enable = true;
    preset.github-ci = {
      enable = config.actionRun.facts != {};
      repo = "gtrunsec/data-science-threat-intelligence";
      sha = config.preset.github-ci.lib.getRevision "Github" null;
    };
  };
}
