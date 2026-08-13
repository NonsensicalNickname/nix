{ config, ... }:
let 
	hostname = config.networking.hostName;
in
{
	fileSystems."/export/${hostname}-nix" = {
		device = "/home/ceri/.config/nix";
		fsType = "none";
		options = [ "bind" ];
	};

	services.nfs.server.enable = true;
	services.nfs.server.exports = ''
		/export         		*(rw,fsid=0,no_subtree_check) 
		/export/${hostname}-nix		*(rw,nohide,insecure,no_subtree_check) 
	'';
}
