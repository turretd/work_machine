{ config, pkgs, ...}:
{
  nix.extraOptions = ''
    trusted-users = franz
  '';
  users.mutableUsers = true;
  users.users.franz = {
    isNormalUser = true;
    extraGroups = ["docker" "input" "wheel"];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;
}
