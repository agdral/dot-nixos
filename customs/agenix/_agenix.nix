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
  postInstallCheck = ''
    shellcheck ${bin}
    ${bin} -h | grep ${version}

    test_tmp=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')
    export HOME="$test_tmp/home"
    export NIX_STORE_DIR="$test_tmp/nix/store"
    export NIX_STATE_DIR="$test_tmp/nix/var"
    mkdir -p "$HOME" "$NIX_STORE_DIR" "$NIX_STATE_DIR"
    function cleanup {
      rm -rf "$test_tmp"
    }
    trap "cleanup" 0 2 3 15

    cd $HOME/secrets
    test $(${bin} -d secret1.age) = "hello"
  '';

  installPhase = ''
    install -D $src ${bin}
  '';

  meta.description = "age-encrypted secrets for NixOS";
}
