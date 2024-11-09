{ pkgs, lib, config, ...}
{
  services= lib.mkIf config.awesome.enable {
    xserver = {
      enable = true;
      windowmanager.awesome = {
	enable = true;
	luaModules= with pkgs.luaPackages; [
	  luarocks
	  luadbi-mysql
	];
      };
    };
    
