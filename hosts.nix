# hosts.nix
{
	erebor = { system = "x86_64-linux"; laptop = true; modules.audio.enable = true; };
	nixvm = { system = "x86_64-linux"; laptop = false; };
	imladris = { 
    system = "x86_64-linux"; 
    laptop = true; 
    modules.audio.enable = true; 
    modules.docker.enable = true; 
    modules.hyprland.enable = true;
    modules.mise.enable = true;
    modules.bluetooth.enable = true;
  };
}
