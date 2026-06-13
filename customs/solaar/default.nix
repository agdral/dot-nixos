{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotNixos;
  name = "solaar";
in {
  options.dotNixos.${name} = mkEnableOption "${name}";
  config = mkIf cfg.${name} {
    services = {
      solaar = {
        enable = true;
        window = "hide";
      };
    };
  };
}
