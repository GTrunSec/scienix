{ inputs, cell }:
{
  default = {
    commands =
      [
        # {
        #   package = inputs.dataflow2nix.iterative.packages.dvc;
        # }
        { package = inputs.dataflow2nix.kedro.packages.kedro; }
      ];
  };
}
