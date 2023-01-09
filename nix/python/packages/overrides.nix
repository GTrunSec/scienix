nixpkgs: final: prev: let
  addNativeBuildInputs = drvName: inputs: {
    "${drvName}" = prev.${drvName}.overridePythonAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ inputs;
    });
  };
in
  {
    inherit (nixpkgs.python3Packages) tensorflow pytorch;

    psutil = nixpkgs.python3Packages.psutil;

    pandas = prev.pandas.overridePythonAttrs (attrs: {
      format = "setuptools";
      enableParallelBuilding = true;
      setupPyBuildFlags = attrs.setupPyBuildFlags or [] ++ ["--parallel" "$NIX_BUILD_CORES"];
    });
  }
  // addNativeBuildInputs "traitlets" [final.hatchling]
  // addNativeBuildInputs "jupyter-client" [final.hatchling]
  // addNativeBuildInputs "ipykernel" [final.hatchling]
  // addNativeBuildInputs "jupyter-core" [final.hatchling]
