{
  fetchurl,
  appimageTools,
  imagemagick,
}:

let
  pname = "responsively";
  version = "1.18.0";

  executableName = "responsivelyapp";

  src = fetchurl {
    url = "https://github.com/responsively-org/responsively-app-releases/releases/download/v${version}/ResponsivelyApp-${version}.AppImage";
    sha256 = "19rvh9if5xxzhr50bzfvhia53s9cjqfynzjaq3lssyr6s2vsa48p";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mv $out/bin/$pname $out/bin/${executableName}
    install -m 444 -D ${appimageContents}/${executableName}.desktop $out/share/applications/${executableName}.desktop
    ${imagemagick}/bin/magick ${appimageContents}/${executableName}.png -resize 512x512 ${pname}_512.png
    install -m 444 -D ${pname}_512.png $out/share/icons/hicolor/512x512/apps/${executableName}.png

    substituteInPlace $out/share/applications/${executableName}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${executableName}'
  '';
}

