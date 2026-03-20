{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };

        modules = [
          {
            nixpkgs.config.allowUnfree = true;
          }
          ./configuration.nix
          ./hardware-configuration.nix

          ./nvidia.nix

          {
            programs.steam.enable = true; # https://wiki.nixos.org/wiki/Steam

            nix.settings = {
              substituters = [ "https://cache.nixos-cuda.org" ];
              trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
            };

          }

          home-manager.nixosModules.home-manager
          # ./home-manager.nix

          {
            home-manager = {
              backupFileExtension = "hm-backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              users.wali = {
                home = {
                  username = "wali";
                  homeDirectory = "/home/wali";
                  stateVersion = "25.11";
                };

                # https://home-manager-options.extranix.com/?query=btop&release=release-25.11
                programs.mangohud = {
                  enable = true;
                  enableSessionWide = true;
                };
                programs.btop.enable = true;
                
              };
            };
          }

          stylix.nixosModules.stylix
        ];
      };
    };
}
