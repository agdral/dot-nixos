{
  description = "Dotfile Default";
  
  outputs = {...}: {
    nixosModules.default = {...}: {
      imports = [
        ./packages
        ./services.nix
      ];
    };
  };
}
