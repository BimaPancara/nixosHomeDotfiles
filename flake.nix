{
  description = "NixOS configuration for Schicksal";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, noctalia, noctalia-greeter, nix-index-database, ... }: {
    nixosConfigurations.Schicksal = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hosts/Schicksal/default.nix

        home-manager.nixosModules.home-manager
        noctalia-greeter.nixosModules.default

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.apokaliph = import ./home/apokaliph.nix;
          home-manager.sharedModules = [
            noctalia.homeModules.default
            nix-index-database.homeModules.nix-index
          ];
        }
      ];
    };

    # Formatter for `nix fmt`
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;

    # Development shell for `nix develop`
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = with nixpkgs.legacyPackages.x86_64-linux; [
        nil              # Nix language server
        nixfmt   # Nix formatter
        statix           # Nix linter
      ];
    };
  };
}
