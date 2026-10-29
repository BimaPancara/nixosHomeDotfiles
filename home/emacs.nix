{ pkgs, ... }:

{
# Add Packages
    home.packages = with pkgs; [
	emacs-nox
	];
}
