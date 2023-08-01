final: prev:
let
  addNativeBuildInputs = drvName: inputs: {
    "${drvName}" = prev.${drvName}.overridePythonAttrs (
      old: { nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ inputs; }
    );
  };
in
{ }
// addNativeBuildInputs "publicsuffixlist" [ final.setuptools ]
// addNativeBuildInputs "plyara" [ final.setuptools ]
// addNativeBuildInputs "eql" [ final.setuptools ]
// addNativeBuildInputs "parsuricata" [ final.poetry ]
// addNativeBuildInputs "stix2-patterns" [ final.setuptools ]
// addNativeBuildInputs "stix2" [ final.setuptools ]
// addNativeBuildInputs "pymisp" [ final.poetry ]
// addNativeBuildInputs "sigmatools" [ final.setuptools ]
