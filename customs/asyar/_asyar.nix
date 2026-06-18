{
  fetchurl,
  appimageTools,
  makeWrapper,
}: let
  pname = "asyar";
  version = "0.1.1-29";

  executableName = "asyar";

  src = fetchurl {
    url = "https://github.com/Xoshbin/asyar/releases/download/v${version}/asyar_${version}_amd64.AppImage";
    sha256 = "0wzv97x1vc6d55rsbyxg4cxjbm4rjgqjcynad7wrh14lh6hvv5jf";
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
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/256x256@2/apps/${executableName}.png $out/share/icons/hicolor/512x512/apps/${executableName}.png
    '';
  }

