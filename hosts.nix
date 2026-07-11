# hosts.nix
{
	erebor = { 
    system = "x86_64-linux"; 
    laptop = true; 
    modules.desktop.enable = true; 
  };
	nixvm = { system = "x86_64-linux"; laptop = false; };
	imladris = {
    system = "x86_64-linux";
    laptop = true;
    modules.desktop.enable = true;
    modules.docker.enable = true;
    modules.mise.enable = true;
  };
}
