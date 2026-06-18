{
  fetchurl,
  appimageTools,
  makeWrapper,
}: let
  pname = "padloc";
  version = "4.3.0";

  executableName = "padloc";

  src = fetchurl {
    url = "https://github.com/padloc/padloc/releases/download/v${version}/padloc_${version}_linux_tauri_amd64.AppImage";
    sha256 = "1707f3dqram2lypw4h41l0mic1bx7y523zw41i0mf31j9wli0jhh";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 {
    inherit pname version src;
    nativeBuildInputs = [makeWrapper];
    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/${executableName}.desktop $out/share/applications/${executableName}.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/512x512/apps/${executableName}.png $out/share/icons/hicolor/512x512/apps/${executableName}.png
    '';
  }
