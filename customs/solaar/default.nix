{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.dotNixos;
in {
  imports = [
    inputs.solaar.nixosModules.default
  ];
  options.dotNixos.solaar = mkOption {
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.solaar {
    services = {
      solaar = {
        enable = true;
        window = "hide";
      };
    };
  };
}
