{ pkgs, ... }:
{
  # List packages installed in system profile.
  # To search, run: $ nix search <package-name>
  # To search in browser: https://search.nixos.org/packages?channel=25.11
  environment.systemPackages = with pkgs; [

    nixfmt
    parted
    aria2
    spotify
    discord
    neofetch
    fastfetch

    gnome-disk-utility

    # --- Base System & Core Utilities ---
    wget
    curl
    git
    gh
    bat
    eza
    btop
    tldr # or 'tealdeer' for a fast Rust rewrite
    e2fsprogs
    ethtool
    fakeroot
    vim

    # --- Development & Languages ---
    clang
    cmake
    gnumake
    python3
    nodejs
    jupyter-all
    nodePackages.eslint
    vscode # or 'vscodium' for the telemetry-free version
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
    libreoffice-qt6 # or 'libreoffice-fresh'
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
    piper # Gaming mouse config
    razergenie # Requires OpenRazer daemon (see below)
    cavalier # Audio visualizer
    vulkan-tools

    # --- TTS / Voice ---
    espeak-ng
  ];
}
