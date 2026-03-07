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

  outputs = {
    nixpkgs,
    import-tree,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
  in {
    nixosModules.default = {...}: {
      imports = [
        ./packages
        (import-tree.filter (lib.hasSuffix "/default.nix") ./services)
        (import-tree.filter (lib.hasSuffix "/default.nix") ./customs)
      ];
      config._module.args = {inherit inputs;};
    };

    nixosModules.tools = ./tools.nix;
  };
}
