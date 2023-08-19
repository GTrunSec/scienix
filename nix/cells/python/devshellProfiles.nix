{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  default = {
    commands = [
      { package = nixpkgs.poetry; }
      {
        name = "poetryWrapper";
        command = ''
          poetry -C "$PRJ_ROOT"/nix/python/packages "$@"
        '';
      }
    ];
  };
}
