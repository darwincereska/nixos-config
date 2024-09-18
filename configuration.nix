# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./modules/bootloader.nix
      ./hardware-configuration.nix
      ./modules/displayServer.nix
      ./modules/zsh.nix
      ./modules/swap.nix
      ./modules/networking.nix
      ./modules/ssh.nix
      ./modules/tailscale.nix
      
    ];

  xdg.portal.enable = true; 
    	 xdg.portal.extraPortals = [ 
    	   pkgs.xdg-desktop-portal-gnome 
    	   (pkgs.xdg-desktop-portal-gtk.override { 
    	     # Do not build portals that we already have. 
    	     buildPortalsInGnome = false; 
    	   }) 
    	 ]; 
    	 # xdg.portal.configPackages = mkDefault [ pkgs.gnome.gnome-session ]; 
    	  
  # services.tailscale.enable = true;
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ]; # Optional; allows customizing optimisation schedule
  environment.sessionVariables = {
      XDG_DATA_DIRS = lib.mkForce "/var/lib/flatpak/exports/share:/home/darwin/.local/share/flatpak/exports/share:/etc/profiles/per-user/root/share:/run/current-system/sw/share";
    };
  
  ssh.enable = true;
  swap.enable = false;
  # unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ]; 
  virtualisation.libvirtd.enable = true; 
  system.stateVersion = "24.05";
  virtualisation.docker.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Detroit";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.darwin = {
    isNormalUser = true;
    description = "Darwin";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "qemu-libvirtd" ];
  };
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "darwin";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  # Allow unfree packages
 nixpkgs = {
      config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
      unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
      };
    };
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

    
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	wget
	zsh
	micro
	neofetch
	git
	zoxide
	busybox
	starship
	zsh-autosuggestions
	gnome.gnome-tweaks
	home-manager
	flatpak
	docker
	libnotify
	# kitty
	
	bat
	gcc
	# rustup
 ];

 # Did you read the comment?

# virtualisation.libvirtd = {
#   qemu = {
#     package = pkgs.qemu_kvm; # only emulates host arch, smaller download
#     swtpm.enable = true; # allows for creating emulated TPM
#     ovmf.packages = [(pkgs.OVMF.override {
#       secureBoot = true;
#       tpmSupport = true;
#     }).fd]; # or use pkgs.OVMFFull.fd, which enables more stuff
#   };
# };
 # xdg.mimeApps = {
 #      "x-scheme-handler/roblox" = "/home/darwin/.local/share/applications/Roblox.desktop";
 #    };
 

}

