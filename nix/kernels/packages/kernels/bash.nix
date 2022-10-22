{
  kernels,
  name,
  ...
} @ args: let
in
  kernels.bash {
    displayName = name;
  }
