{ config, pkgs, lib, ... }:
{
	options = {
		ssh.enable = 
			lib.mkEnableOption "Enables SSH";
	};
	
	config = lib.mkIf config.ssh.enable {
		programs.mtr.enable = true;
		programs.gnupg.agent = {
		 enable = true;
		 enableSSHSupport = true;
		};
		services.openssh.enable = true;
	};



	
  

}
