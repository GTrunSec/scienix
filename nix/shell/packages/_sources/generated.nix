# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  nu-plugin-from-parquet = {
    pname = "nu-plugin-from-parquet";
    version = "eb32b24527ec171f07385511271e937f314ee1f5";
    src = fetchFromGitHub ({
      owner = "fdncred";
      repo = "nu_plugin_from_parquet";
      rev = "eb32b24527ec171f07385511271e937f314ee1f5";
      fetchSubmodules = false;
      sha256 = "sha256-L6s8ye2lpxHTLVOmddg4Q4/zQ1x1wwtnL1CvaBpW244=";
    });
    cargoLock."Cargo.lock" = {
      lockFile = ./nu-plugin-from-parquet-eb32b24527ec171f07385511271e937f314ee1f5/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2022-11-30";
  };
  nu-plugin-regex = {
    pname = "nu-plugin-regex";
    version = "ae215fae3690e187703384ce3d99d27d257a5baf";
    src = fetchFromGitHub ({
      owner = "fdncred";
      repo = "nu_plugin_regex";
      rev = "ae215fae3690e187703384ce3d99d27d257a5baf";
      fetchSubmodules = false;
      sha256 = "sha256-4IrsdHeIA2ZO2bqyu0r+acFTG2nuZUFVRjNplPGkYKc=";
    });
    cargoLock."Cargo.lock" = {
      lockFile = ./nu-plugin-regex-ae215fae3690e187703384ce3d99d27d257a5baf/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2022-12-15";
  };
}
