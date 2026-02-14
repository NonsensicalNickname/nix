set word $(wl-paste --primary | sed "s/[[:space:]]//")

set query $(curl -s --connect-timeout 5 --max-time 10 "https://api.dictionaryapi.dev/api/v2/entries/en_GB/$word")

if test "$(echo $query | grep "No Definitions Found")" != ""
    notify-send "No def found"
else 
    set def $(
        echo "$query" | jq -r '.[0].meanings[] | "\(.partOfSpeech): \(.definitions[0].definition)\n"'
    )
    notify-send -t 60000 "$word -" "$def"
end
