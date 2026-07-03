sudo mkdir /tmp/disko
sudo cp -r etc /tmp/disko

sudo nix run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake '/tmp/disko/etc/nixos#bimgus' --disk main /dev/nvme1n1
