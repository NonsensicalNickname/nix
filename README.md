# Nix Configs

My NixOS monorepo containing configuration, options, and containers, with a structure inspired by NotAShelf/nyx.
No generative AI used for anything.

## Machines

The naming scheme used for my machine can be found [here](https://codeberg.org/ceridwen15/yuriary-nomenclature), 
and a list of my current machines [here](https://codeberg.org/ceridwen15/yuriary-nomenclature/src/branch/main/MACHINES.md).   

Currently configured machines are andropov, kochiyama, and knorozov (see above for table of specs).   

## Installation

### Testing an Existing Configuration (Use this for convenience)

This repo provides iso files for existing configurations. See releases for isos, and test them
in a VM such as VirtualBox - for now only knorozov has an image due to practicality concerns.
The main user in any config image is called `guest`, with the password `guest`.

### Build an Image

Instructions on how to build an iso for testing out one of the host configurations in this repo.

0. Clone this repo and `cd` into it
1. Pick a host or create a new one (detailed in the manual installation instructions). Use this name in place of HOSTNAME below.
2. Run `nix build .#nixosConfigurations.HOSTNAME-iso.config.system.build.isoImage -o iso`

### Manual

0. Follow the installation guide on the [NixOS wiki](https://wiki.nixos.org/wiki/NixOS_Installation_Guide/en) to install NixOS from the minimal ISO.
Continue with these steps once you are able to boot into a working installation. Make sure that you have git and a text editor such as vim installed.
1. Clone this repo and `cd` into it
2. Not really a step, but HOSTNAME refers to the current hostname of the system. 
3. Create a directory named HOSTNAME in the hosts/ directory of this repo
4. In hosts/HOSTNAME, create hardware.nix and host.nix
5. Populate hardware.nix by running 
`nixos-generate-config --show-hardware-config >> hosts/HOSTNAME/hardware.nix`
6. Populate hosts.nix. See the other hosts for examples, or use this as a base:
    ```nix
        { pkgs, ... }:
        {
            imports = [ ./hardware.nix ];
            config.modules = {
                environment.shell = {
                    name = "zsh";
                    package = pkgs.zsh;
                };
            };

            config.system.stateVersion = "26.05"; # Change as needed - check with nixos-version
        }
    ```
7. Add an entry to hosts/default.nix. This is done at the bottom of the file, and the 
other hosts may be used as reference. Adding graphical to traits, or `extraModules = homes;` will
significantly increase the download and build duration, as it will build a full desktop system.

   An example:
   ```nix
            {
                hostname = "HOSTNAME";
                traits = [ headless ];
            }

   ```
8. Make sure you are in the root of the repo and run `git add .` and then 
`sudo nixos-rebuild switch --flake . --impure`
9. All should be well
