{
  inputs,
  cell,
}: let
  inherit (cell.library) nixpkgs;
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
          cd $PRJ_ROOT/playground
          julia -E "using Pluto; Pluto.run(host=\"$1\", port=$2)"
        '';
        help = "launch pluto server: pluto <ip> <port>";
      }
    ];
  };
}
