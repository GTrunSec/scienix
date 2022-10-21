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
}
