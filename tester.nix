{
  self,
  inputs,
  lib,
  ...
}: {
  tester = lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      self.nixosModules.default
      {
        boot.loader.grub.enable = false;
        fileSystems."/" = {device = "/dev/null";};
        system.stateVersion = "26.05";
      }
      {
        dotNixos = {
          bluetooth = true;
          docker = true;
          openTablet = true;
          openssh = true;
          pipewire = true;
          solaar = true;
          sonixQmk = true;
          agenix = true;
          xserver = true;
        };
      }
    ];
  };
}
