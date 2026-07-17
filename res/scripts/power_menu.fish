set cmd (echo -e "poweroff\nreboot\nlock\nrebuild nix" | fuzzel -d)
if test "$cmd" = "rebuild nix"
    set res (fish -c "nh os switch --impure --elevation-strategy run0")
    if test $res = 0
        notify-send -u normal "rebuild success"
    else
        notify-send -u normal "rebuild failed"
    end
else
    $cmd
end
