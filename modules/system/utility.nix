{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vim
    jq
    gzip
    unzip 
    curl 
    wget
    btop
  ];
}
