{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.solaar = mkEnableOption "solaar";
  config = mkIf cfg.solaar {
    services = {
      solaar = {
        enable = true;
        window = "hide";
      };
    };
  };
}
