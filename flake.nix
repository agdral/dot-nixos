{
  description = "Dotfile Default";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    import-tree.url = "github:vic/import-tree";
    agenix.url = "github:ryantm/agenix";

    nixstable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";

    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixstable";
    };
  };

  outputs = {
    nixpkgs,
    import-tree,
    solaar,
    agenix,
    ...
  }: let
    lib = nixpkgs.lib;
  in {
    nixosModules.default = {...}: {
      imports = [
        agenix.nixosModules.default
        solaar.nixosModules.default
        ./packages
        (import-tree.filter (lib.hasSuffix "/default.nix") ./services)
      ];

      environment.systemPackages = [
        agenix.packages.x86_64-linux.default
      ];
    };

    nixosModules.tools = ./tools.nix;
  };
}
