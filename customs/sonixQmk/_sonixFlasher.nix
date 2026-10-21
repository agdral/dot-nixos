{
  stdenv,
  fetchzip,
  autoPatchelfHook,
  hidapi,
  ...
}:
stdenv.mkDerivation {
  pname = "sonixFlasherC";
  version = "3.0.0";

  src = fetchzip {
    url = "https://github.com/SonixQMK/SonixFlasherC/releases/download/3.0.0/sonixflasher-linux-x86_64.zip";
    hash = "sha256-KokN8mu0J9EHCzq2C9mwNboEE4/nK9PjVMT/lOofJJU=";
    stripRoot = false;
  };

  nativeBuildInputs = [autoPatchelfHook];
  buildInputs = [hidapi];

  installPhase = ''
    mkdir -p $out/bin
    cp sonixflasher $out/bin/
    chmod +x $out/bin/sonixflasher
  '';
}
