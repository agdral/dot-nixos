{
  description = "Dotfile Default";

  outputs = {...}: {
    nixosModules.default = {...}: {
      imports = [
        ./packages
        ./services
      ];
    };
    nixosModules.tools = ./tools.nix;
  };
}
