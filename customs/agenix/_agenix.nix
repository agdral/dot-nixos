{
  lib,
  stdenv,
  age,
  jq,
  nix,
  mktemp,
  diffutils,
  replaceVars,
  ageBin ? "${age}/bin/age",
  shellcheck,
}:
let
  bin = "${placeholder "out"}/bin/agenix";
in
stdenv.mkDerivation rec {
  pname = "agenix";
  version = "0.15.0";
  src = replaceVars ./agenix.sh {
    inherit ageBin version;
    jqBin = "${jq}/bin/jq";
    nixInstantiate = "${nix}/bin/nix-instantiate";
    mktempBin = "${mktemp}/bin/mktemp";
    diffBin = "${diffutils}/bin/diff";
  };
  dontUnpack = true;
  doInstallCheck = true;
  installCheckInputs = [ shellcheck ];

  installPhase = ''
    install -D $src ${bin}
  '';

  meta.description = "age-encrypted secrets for NixOS";
}
