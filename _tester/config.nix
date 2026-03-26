{
  self,
  inputs,
  lib,
  ...
}: let
  system = "x86_64-linux";
in {
  tester = lib.nixosSystem {
    inherit system;
    modules = [
      {
        nixpkgs.config.allowUnfree = true;
        boot.loader.grub.enable = false;
        fileSystems."/" = {device = "/dev/null";};
        system.stateVersion = "26.05";

        imports = [
          self.nixosModules.default
        ];
      }
    ];
  };
}
