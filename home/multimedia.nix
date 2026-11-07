{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Video / Audio
    mpv
    termusic

    # Images
    feh

    # YouTube
    youtube-tui
    yt-dlp
  ];
}
