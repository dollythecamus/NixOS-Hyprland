# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options

{ pkgs, inputs, ...}: let

  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        ]
    );

  in {

  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = (with pkgs; [
  # System Packages
    baobab
    btrfs-progs
    clang
    curl
    cpufrequtils
    duf
    eza
    ffmpeg   
    glib #for gsettings to work
    gsettings-qt
    git
    killall  
    libappindicator
    libnotify
    openssl #required by Rainbow borders
    pciutils
    vim
    wget
    xdg-user-dirs
    xdg-utils

    fastfetch
    (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
    #ranger
      
    # Hyprland Stuff
    ags # note: defined at flake.nix to download and install ags v1    
    btop
    brightnessctl # for brightness control
    cava
    cliphist
    eog
    gnome-system-monitor
    grim
    gtk-engine-murrine #for gtk themes
    hypridle # requires unstable channel
    imagemagick 
    inxi
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum #kvantum
    networkmanagerapplet
    nwg-look
    nvtopPackages.full	 
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum #kvantum
    rofi-wayland
    slurp
    swappy
    swaynotificationcenter
    swww
    unzip
    wallust
    wl-clipboard
    wlogout
    xarchiver
    yad
    yt-dlp

 # Commented most of these because now installing with flatpak
 # flatpak feels more reliable, still experimenting
 # update: flatpak isn't exactly more reliable, I can and should still use these.
    # prismlauncher # Minecraft
    obsidian # Obsidian
    ckan # KSP Moding
    godot_4 # Godot 4, for gamedev
    blender # Blender, for 3D modeling, CAD and rendering
    krita # Krita, painting software
    # obs-studio # OBS for streaming # via flatpak
    qbittorrent # torrent client

    everforest-gtk-theme # Everforest!
    
    lutris # Lutris to install/run pirated games 

    wine # Windows game runner

    github-desktop # to use github without problems

    #waybar  # if wanted experimental next line

    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	  python-packages
  ];

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
	  terminus_font
    (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    #nerd-fonts.jetbrains-mono # unstable
    #nerd-fonts.fira-code # unstable
 	];
  
  programs = {
	  hyprland = {
      enable = true;
		    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
		    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  	  xwayland.enable = true;
      };

	
	  waybar.enable = true;
	  hyprlock.enable = true;
	  firefox.enable = true;
	  git.enable = true;
    nm-applet.indicator = true;
    #neovim.enable = true;

	  thunar.enable = true;
	  thunar.plugins = with pkgs.xfce; [
		  exo
		  mousepad
		  thunar-archive-plugin
		  thunar-volman
		  tumbler
  	  ];
	
    virt-manager.enable = false;
    
    #steam = {
    #  enable = true;
    #  gamescopeSession.enable = true;
    #  remotePlay.openFirewall = true;
    #  dedicatedServer.openFirewall = true;
    #};
    
    xwayland.enable = true;

    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    
    };
	
  };
  # OBS Virtual camera
  # programs.obs-studio.enableVirtualCamera = true;

  # Steam, for gaming
  programs.steam = {
	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
  };


  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    };

  }
