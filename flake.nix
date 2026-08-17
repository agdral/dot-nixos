{
  description = "Nixos Dotfile";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixstable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";

    import-tree.url = "github:vic/import-tree";

  };

  outputs = inputs @ {
    self,
    nixpkgs,
    import-tree,
    ...
  }: let
    lib = nixpkgs.lib;
  in {
    nixosModules.default = {
      imports = [
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
