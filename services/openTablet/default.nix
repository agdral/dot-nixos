{pkgs-stable, ...}: {
  hardware = {
    opentabletdriver = {
      enable = true;
      package = pkgs-stable.opentabletdriver;
    };
  };
}
