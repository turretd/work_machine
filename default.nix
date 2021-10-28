let
  work_machine = (import <nixpkgs/nixos> {
    system = "x86_64-linux";
    configuration = import ./configuration.nix;
  }).system;
in { inherit work_machine; }