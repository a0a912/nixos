{ inputs, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # search home manager options:
  # https://home-manager-options.extranix.com/?query=btop&release=release-25.11

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

      programs.mangohud = {
        enable = true;
        enableSessionWide = true;
      };

      programs.btop = {
        enable = true;
        package = pkgs.btop-cuda;
      };

      programs.nh = {
        enable = true;
      };

      programs.bash = {
        enable = true;
        shellAliases = {
          nfu = "nix flake update"; # update flake lock file
          nrs = "nh os switch"; # switch to new config and add to boot screen

          nrt = "nh os test"; # switch to new config, but don't add to boot screen
          nrb = "nh os boot"; # don't switch to new config, but add to boot screen

          nfc = "nix flake check"; # check flake syntax

          ns = "nix-shell -p "; # open a nix-shell with the specified package(s). usage: `ns <package-name>`
        };
      };
    };
  };
}
