{sources ? import ./nix/sources.nix { }, pkgs ? import sources.nixpkgs {}}:
{
  machine = (import "${sources.nixpkgs}/nixos" {
    system = "x86_64-linux";
    configuration = import ./configuration.nix;
  }).system;
}
