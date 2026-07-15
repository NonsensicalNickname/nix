wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
set state $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)

if test "$(echo $state | grep "MUTED")" != ""
    openrgb -c FF0000
else
    openrgb -b 0
end
