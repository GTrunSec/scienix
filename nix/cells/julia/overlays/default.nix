{ inputs, cell }:
{
  default =
    final: prev:
    let
    in
    {
      inherit (inputs.julia2nix.packages."${prev.system}") julia_19-bin;
    };
}
