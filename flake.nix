{
  description = "Dotfile Default";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    import-tree.url = "github:vic/import-tree";
    nixstable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";

    # Customs
    agenix.url = "github:ryantm/agenix";
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixstable";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    import-tree,
    agenix,
    solaar,
    ...
  }: let
    lib = nixpkgs.lib;
  in {
    nixosModules.default = {
      imports = [
        agenix.nixosModules.default
        solaar.nixosModules.default
        ./packages
        (import-tree.filter (lib.hasSuffix "/default.nix") ./services)
        (import-tree.filter (lib.hasSuffix "/default.nix") ./customs)
      ];
    };

    nixosConfigurations = import ./tester.nix {
      inherit self inputs lib;
    };
  };
}
