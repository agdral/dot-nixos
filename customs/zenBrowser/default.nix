{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  zenBrowser_pack = pkgs.callPackage ./_zenBrowser.nix {};
  name = "zenBrowser";
in {
  options.dotNixos.${name} = mkEnableOption "${name}";
  config = mkIf cfg.${name} {
    environment.systemPackages = [
      zenBrowser_pack
    ];
  };
}

