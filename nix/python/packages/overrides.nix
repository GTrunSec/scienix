nixpkgs: final: prev: let
  addNativeBuildInputs = drvName: inputs: {
    "${drvName}" = prev.${drvName}.overridePythonAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ inputs;
    });
  };
in
  {
    inherit (nixpkgs.python3Packages) tensorflow matplotlib;
  }
  // addNativeBuildInputs "traitlets" [final.hatchling]
  // addNativeBuildInputs "jupyter-client" [final.hatchling]
  // addNativeBuildInputs "ipykernel" [final.hatchling]
  // addNativeBuildInputs "jupyter-core" [final.hatchling]
