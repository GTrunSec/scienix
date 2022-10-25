{
  cell,
  inputs,
}: let
  inherit (cell.library) dependencies;

  cmd = type: text: {
    command = {inherit type text;};
  };
in {
  julia = {...}:
    cmd "shell" "julia --version"
    // {dependencies = [cell.packages.julia-wrapped];};

  doc = {pkgs, ...}:
    cmd "shell" ''
      echo "$PATH" | tr : "\n"
      nix eval --raw .\#x86_64-linux.julia.packages.jnumpy
    ''
    // {
      preset.nix.enable = true;
      memory = 2000;
    };

  nix-build = {config, ...}: {
    command.text = "nix build";
    memory = 4 * 1024;
    preset.nix.enable = true;
    preset.github-ci = {
      enable = config.actionRun.facts != {};
      repo = "gtrunsec/data-science-threat-intelligence";
      sha = config.preset.github-ci.lib.getRevision "Github" null;
    };
  };
}
