{ config, pkgs, ... }:
{
	# Hostname for OS
	networking.hostName = "nixos";

	# Enable networking
	networking.networkmanager.enable = true;

	# Enables wireless support via wpa_supplicant.
	# networking.wireless.enable = true; 

	
}
