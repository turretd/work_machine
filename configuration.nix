# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    ./users.nix
    #./mongodb.nix
    #./docker-fix.nix
  ];

  services.self-deploy = {
    enable = true;
    repository = "git@github.com:turretd/work_machine";
    startAt = "hourly";
    nixAttribute = "machine";
  };


  nixpkgs.config.allowUnfree = true;

  nix.autoOptimiseStore = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "zeche-ewald"; # Define your hostname.
  time.timeZone = "Europe/Amsterdam";
  environment.systemPackages = with pkgs; [
    git
    vim
    fd
    bat
    ripgrep
    openssl
    pinentry
  ];
  services.lorri.enable = true;
  services.xserver = {
    enable = true;
    desktopManager = {
    xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager.i3.enable = true;
    displayManager.defaultSession = "xfce+i3";
  };

  virtualisation.podman.enable = true;
  networking.useDHCP = false;
  networking.interfaces.ens33.useDHCP = true;

  networking.firewall.allowedTCPPorts = [ 27017 ];

  system.stateVersion = "21.05"; # Did you read the comment?

}

