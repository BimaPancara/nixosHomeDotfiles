

{ config, pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
  };

  users.users.apokaliph = {
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];

    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    podman
    podman-compose
  ];
}
