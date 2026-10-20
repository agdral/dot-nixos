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
    sha256 = "1fvdkj0rzxyilfsxllmglkdjaxq4gwsxhpn90m5awfs2grva3h1g";
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
