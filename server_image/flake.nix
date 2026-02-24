# See old wiki page:
# https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
{
    description = "install media for fag server";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    outputs = { self, nixpkgs }: {
        nixosConfigurations = {
            server = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ({ pkgs, modulesPath, ... }: {
                        imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
                        environment.systemPackages = with pkgs; [ 
                            git
                            vim
                            fastfetch
                            hyfetch
                        ];

                        systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
                        users.users.root.openssh.authorizedKeys.keys = [
                            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYRz8gcRysrisod32rt4r2NSdcarg+fy0WPgf7LJP04 ceri@goose"
                        ];
                    })
                ];
            };
        };
    };
}
