{
  fetchurl,
  appimageTools,
  imagemagick,
}:

let
  pname = "zen";
  version = "1.21.1b";

  executableName = "zen";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen-x86_64.AppImage";
    sha256 = "1i2q9xvas5qwfy6jm6rxndpb6z9caxapn7858rvlzpxv45i8b6fp";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${executableName}.desktop $out/share/applications/${executableName}.desktop
    ${imagemagick}/bin/magick ${appimageContents}/${executableName}.png -resize 512x512 ${pname}_512.png
    install -m 444 -D ${pname}_512.png $out/share/icons/hicolor/512x512/apps/${executableName}.png
  '';
}


