{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  options.dotNixos.openssh = mkEnableOption "openssh";
  config = mkIf cfg.openssh {
    services = {
      openssh = {
        enable = true;
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "prohibit-password";
      };
    };
  };
}
