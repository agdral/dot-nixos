{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      input = {
        General = {
          UserspaceHID = true;
          ClassicBondedOnly = false;
        };
      };
    };
  };
  services = {
    blueman.enable = true;
  };
}
