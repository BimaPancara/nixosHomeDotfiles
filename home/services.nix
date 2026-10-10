{ pkgs, ... }:


{

services.udiskie = {
	enable = true;
	tray = "never";
    };
services.ssh-agent.enable = true;

}

