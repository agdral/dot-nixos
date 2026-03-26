{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.pipewire = mkEnableOption "pipewire";
  config = mkIf cfg.pipewire {
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
    };
  };
}
