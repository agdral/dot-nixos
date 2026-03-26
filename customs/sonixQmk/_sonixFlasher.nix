{
  stdenv,
  fetchzip,
  autoPatchelfHook,
  hidapi,
  ...
}:
stdenv.mkDerivation {
  pname = "sonixFlasherC";
  version = "2.0.8";

  src = fetchzip {
    url = "https://github.com/SonixQMK/SonixFlasherC/releases/download/2.0.8/sonixflasher-linux-x86_64.zip";
    sha256 = "sha256-071Uf560gbA9f5PIFGa17Sos4owjFXvmUOMoLeBDOEw=";
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
