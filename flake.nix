{
  description = "Nixos Dotfile";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixstable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";

    import-tree.url = "github:vic/import-tree";

    # Customs
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixstable";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    import-tree,
    solaar,
    ...
  }: let
    lib = nixpkgs.lib;
  in {
    nixosModules.default = {
      imports = [
        solaar.nixosModules.default
        ./packages
        (import-tree.filter (lib.hasSuffix "/default.nix") ./services)
        (import-tree.filter (lib.hasSuffix "/default.nix") ./customs)
      ];
    };

    nixosConfigurations = import _tester/config.nix {
      inherit self inputs lib;
    };
  };
}
