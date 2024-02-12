# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "paul-thinkpad"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchDocked = "suspend";
    lidSwitchExternalPower = "suspend";
  };
  systemd.services.lock_screen = {
    description = "Activate lock screen when leaving active state.";
    wantedBy = [
      "hibernate.target"
      "sleep.target"
      "suspend-then-hibernate.target"
      "suspend.target"
    ];
    serviceConfig = {
      Type = "forking";
      Environment="DISPLAY=:0";
      User = "paul";
      ExecStart = "/run/current-system/sw/bin/i3lock -n -e -f -c 000000";
    };
  };


  services.xserver = {
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # Enable the X11 windowing system.
    enable =  true;
  
    # Configure keymap in X11
    layout = "za";
    xkbVariant = "";
    xkbOptions = "grp:swap_alt_win";
     
    displayManager = {
      # Enable the XFCE Desktop Environment.
      lightdm.enable = true;
      # Enable i3
      defaultSession = "none+i3";
    };
  
    desktopManager = {
      # unset for i3
      xterm.enable = false;
      # Enable the XFCE Desktop Environment.
      xfce.enable = true;
    };
  
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
      ];
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.paul = {
    isNormalUser = true;
    description = "Paul Menhart";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

   # Set default editor to vim
  environment.variables.EDITOR = "vim";

  # links /libexec from derivations to /run/current-system/sw 
  environment.pathsToLink = [ "/libexec" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # basics
    (import ./lock.nix)
    file
    git
    gnome.gnome-calculator
    gnome.gnome-calendar
    gnome.gnome-control-center
    gnome.gnome-screenshot
    gnome.nautilus
    wget

    #tools
    thunderbird
    firefox
    keepassxc
    neovim

    # programming languages
    cargo
    kotlin
    lua
    nodejs_21
    perl
    python3
    ruby
    rustc
    zig
    zulu
  ];
  fonts.packages = with pkgs; [ nerdfonts ];

  ## make gnome-calendar work XXX needed?
  #programs.dconf.enable = true;
  #services.gnome.evolution-data-server.enable = true;
  ## optional to use google/nextcloud calendar
  #services.gnome.gnome-online-accounts.enable = true;
  ## optional to use google/nextcloud calendar
  #services.gnome.gnome-keyring.enable = true;

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
