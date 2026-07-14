{ configured, ... }:
let
    cursor = configured.style.cursor;
in
{
    config.home.pointerCursor = {
        enable = true;
        name = cursor.name;
        package = cursor.package;
        size = cursor.size;
    };
}
