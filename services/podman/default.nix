{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.podman = mkEnableOption "podman";
  config = mkIf cfg.podman {
    virtualisation.containers.enable = true;
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
