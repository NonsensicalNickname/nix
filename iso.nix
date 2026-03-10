{ config, pkgs, ... }:
{
    imports = [
        <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

        # Provide an initial copy of the NixOS channel so that the user
        # doesn't need to run "nix-channel --update" first.
        <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ];
    environment.systemPackages = [ pkgs.neovim ];

    systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
    users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYRz8gcRysrisod32rt4r2NSdcarg+fy0WPgf7LJP04 ceri@goose"
    ];
}
