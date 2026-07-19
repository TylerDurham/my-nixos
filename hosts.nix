# hosts.nix
{
	erebor = { 
    system = "x86_64-linux"; 
    laptop = true; 
    modules.desktop.enable = true; 
    modules.docker.enable = true;
    modules.development.enable = true;
  };
	nixvm = { system = "x86_64-linux"; laptop = false; };
	imladris = {
    system = "x86_64-linux";
    laptop = true;
    modules.desktop.enable = true;
    modules.docker.enable = true;
    modules.development.enable = true;
    modules.gaming.enable = true;
  };
}
