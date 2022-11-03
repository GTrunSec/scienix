{
  inputs,
  cell,
}: let
  inherit (cell.lib) nixpkgs;
in {
  default = {...}: {
    commands = [
      {
        package = cell.packages.julia-wrapped;
        help = nixpkgs.julia_18-bin.meta.description;
      }
      {
        name = "pluto";
        category = "Julia Package";
        command = ''
          julia -E "using Pluto; Pluto.run(host=\"$1\", port=$2)"
        '';
        help = "launch pluto server: pluto <ip> <port>";
      }
    ];
  };
}
