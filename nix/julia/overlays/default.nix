{
  inputs,
  cell,
}: {
  default = final: prev: let
  in {
    inherit
      (inputs.julia2nix.packages."${prev.system}")
      julia_18-bin
      ;
  };
}
