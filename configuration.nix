# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

  boot.loader.systemd-boot.configurationLimit = 3;

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wali = {
    isNormalUser = true;
    description = "wali";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  services.flatpak.enable = true;
  programs.appimage.enable = true;

  virtualisation.virtualbox.host.enable = true;

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";



  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowUnfreePackages = [ "spotify" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # https://search.nixos.org/options?channel=25.11
    nixfmt
    parted
    aria2
    spotify
    discord
    neofetch
    fastfetch
    vulkan-tools  # gives you vulkaninfo


    gnome-disk-utility

  
    # --- Base System & Core Utilities ---
    wget
    curl
    git
    gh
    bat
    eza
    btop
    tldr               # or 'tealdeer' for a fast Rust rewrite
    e2fsprogs
    ethtool
    fakeroot
    vim

    # --- Nix Formatter ---
    #nixfmt-rfc-style   # Modern standard nix formatter

    # --- Development & Languages ---
    clang
    cmake
    gnumake
    python3
    nodejs
    jupyter-all
    nodePackages.eslint
    vscode             # or 'vscodium' for the telemetry-free version
    sublime

    # --- Browsers & Internet ---
    floorp-bin
    brave
    firefox
    librewolf
    filezilla
    rclone
    rclone-browser
    transmission_4-gtk # or 'transmission_4-qt'
    deluge

    # --- Gaming & Emulation ---
    heroic-unwrapped
    lutris-unwrapped
    bottles
    protonup-qt
    protontricks
    protonplus
    gogdl
    pcsx2
    duckstation
    ppsspp
    melonDS
    desmume
    vbam

    # --- Audio, Video & Graphics ---
    ffmpeg
    vlc
    audacity
    audacious
    ocrmypdf
    ghostscript

    # --- Documents & Office ---
    libreoffice-qt6    # or 'libreoffice-fresh'
    abiword
    evince
    pdfarranger
    foliate
    pdfgrep
    enscript

    # --- Utilities & Tools ---
    bitwarden-desktop
    bleachbit
    timeshift
    caffeine-ng
    hw-probe
    piper              # Gaming mouse config
    razergenie         # Requires OpenRazer daemon (see below)
    cavalier           # Audio visualizer

    # --- TTS / Voice ---
    espeak-ng

    # --- Flatpak Fallbacks / AppImages ---
    # AppImages don't work natively on NixOS. If you rely on them, use this:
    appimage-run
  
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
