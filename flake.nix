
{
  description = "NixOS configuration for Schicksal";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
    url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache   
    };

  };

  outputs = { nixpkgs, home-manager, noctalia, ... }: {
    nixosConfigurations.Schicksal = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hosts/Schicksal/default.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.apokaliph = import ./home/apokaliph.nix;
	   home-manager.sharedModules = [
            noctalia.homeModules.default
          ];
        }
      ];
    };
  };
}
