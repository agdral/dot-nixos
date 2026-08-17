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
    programs = {
      solaar = {
        enable = true;
        userService = {
          enable = true;
          window = "hide";
        };
      };
    };
  };
}
