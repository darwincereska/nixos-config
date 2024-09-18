{ config, pkgs, lib, ...}:
{
	options = {
		swap.enable = 
			lib.mkEnableOption "Enables Swap";
	};

	config = lib.mkIf config.swap.enable {
		# Sets Swap Size
		swapDevices = [{
		   device = "/swapfile";
		   size = 5 * 1024;
		 }];

	};
	
}

	
