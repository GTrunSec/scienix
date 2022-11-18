{
  cell,
  inputs,
}: let
  cmd = type: text: {
    command = {inherit type text;};
  };
in {
  julia = {pkgs, ...}:
    cmd "shell" "julia --version"
    // {dependencies = [cell.packages.julia-wrapped];};

  ci = {
    config ? {},
    pkgs,
    ...
  }:
    cmd "shell" ''
      echo Fact:
      cat ${pkgs.writeText "fact.json" (builtins.toJSON (config.facts.push or ""))}
      echo CI passed
    ''
    // {
      after = [
        "update"
        "julia"
      ];
    };

  update = {
    pkgs,
    config,
    ...
  }:
    cmd "shell" "nix flake lock --update-input std"
    // {
      preset.nix.enable = true;
    };

  jnumpy = {
    pkgs,
    lib,
    ...
  }:
    cmd "shell" ''
      echo "$PATH" | tr : "\n"
      nix build -Lv .#packages.x86_64-linux.jnumpy --extra-experimental-features 'flakes nix-command'
    ''
    // {
      preset.nix.enable = true;
      memory = 4 * 1024;
      nsjail.mount."/tmp".options.size = 8096;
    };

  nix-build = {config, ...}: {
    command.text = "nix build --extra-experimental-features 'flakes nix-command' .#jnumpy";
    memory = 4 * 1024;
    nsjail.mount."/tmp".options.size = 8096;
    preset.nix.enable = true;
    preset.github = {
      ci.enable = config.actionRun.facts != {};
      status = {
        repository = "gtrunsec/data-science-threat-intelligence";
        revision = "main";
      };
    };
  };
}
