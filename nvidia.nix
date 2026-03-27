{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
  ];

  # https://wiki.nixos.org/wiki/CUDA#Setting_up_CUDA_Binary_Cache
  nix.settings = {
    extra-substituters = [ "https://cache.nixos-cuda.org" ];
    extra-trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
  };

  hardware.graphics.enable32Bit = true;

  # NVIDIA PRIME configuration for hybrid graphics
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime = {
      # Bus IDs from: lspci | grep -E "VGA|3D"
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true; # Provides `nvidia-offload` command
      };

      # reverseSync.enable = true;
    };
  };

  # disable system suspend/hibernate when using NVIDIA specialization to avoid resuming to a black screen on integrated/external displays.
  systemd.services."systemd-suspend.service".serviceConfig.ExecStart = "${pkgs.coreutils}/bin/true";
  systemd.services."systemd-hibernate.service".serviceConfig.ExecStart = "${pkgs.coreutils}/bin/true";
  systemd.services."systemd-hybrid-sleep.service".serviceConfig.ExecStart =
    "${pkgs.coreutils}/bin/true";

  # boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

  services.xserver.videoDrivers = [ "nvidia" ];

  boot = {
    kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
    ];
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
  };

  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
}
