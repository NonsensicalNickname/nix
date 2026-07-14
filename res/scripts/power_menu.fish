set cmd (echo -e "poweroff\nreboot\nlock\nrebuild nix" | fuzzel -d)
if test "$cmd" = "rebuild nix"
    sudo nixos-rebuild switch --flake /home/ceri/.config/nix/ --impure
else
    $cmd
end
