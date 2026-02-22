{
  description = "Dotfile Default";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    import-tree.url = "github:vic/import-tree";

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
    ...
  }: let
    lib = nixpkgs.lib;
  in {
    nixosModules.default = {...}: {
      _module.args = {
        inherit solaar;
      };
      imports = [
        ./packages
        (import-tree.filter (lib.hasSuffix "/default.nix") ./services)
      ];
    };

    nixosModules.tools = ./tools.nix;
  };
}
