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
}
