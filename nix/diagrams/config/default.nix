{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs matrix-attack-data;
  inherit (inputs.cells.main.library) __inputs__ l;
in {
  zeek-smtp = l.mapAttrs (n: v: { value = v; }) matrix-attack-data.zeek.config.smtp;
}
