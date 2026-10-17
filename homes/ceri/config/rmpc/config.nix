{
    xdg.configFile."rmpc/config.ron" = {
        enable = true;
        text = ''
            #![enable(implicit_some)]
            #![enable(unwrap_newtypes)]
            #![enable(unwrap_variant_newtypes)]
            (
                theme: "rosepine-main",
                max_fps: 60,
                search: (
                    case_sensitive: false,
                    ignore_diacritics: true,
                    search_button: false,
                    mode: Contains,
                    tags: [
                        (value: "any",         label: "Any Tag"),
                        (value: "artist",      label: "Artist"),
                        (value: "album",       label: "Album"),
                        (value: "albumartist", label: "Album Artist"),
                        (value: "title",       label: "Title"),
                        (value: "filename",    label: "Filename"),
                        (value: "genre",       label: "Genre"),
                    ],
                ),
                tabs: [
                    (
                        name: "Queue",
                        pane: Split(
                            direction: Vertical,
                            panes: [
                                (
                                    size: "65%",
                                    pane: Split (
                                        direction: Horizontal,
                                        panes: [
                                            (
                                                size: "35%",
                                                pane: Split(
                                                    direction: Vertical,
                                                    panes: [
                                                        (
                                                            size: "100%",
                                                            borders: "LEFT | RIGHT | TOP",
                                                            border_symbols: Rounded,
                                                            pane: Pane(AlbumArt)
                                                        ),
                                                        (
                                                            size: "7",
                                                            borders: "ALL",
                                                            border_symbols: Inherited(parent: Rounded, top_left: "├", top_right: "┤",),
                                                            border_title: [(kind: Text(" Lyrics "))],
                                                            border_title_alignment: Right,
                                                            pane: Pane(Lyrics)
                                                        ),
                                                    ],
                                                ),
                                            ), 
                                            (
                                                size: "65%",
                                                pane: Split(
                                                    direction: Vertical,
                                                    panes: [
                                                        (
                                                            size: "3",
                                                            borders: "ALL",
                                                            border_symbols: Inherited(parent: Rounded, bottom_left: "├", bottom_right: "┤",),
                                                            pane: Split(
                                                                direction: Horizontal,
                                                                panes: [
                                                                    (
                                                                        size: "1",
                                                                        pane: Pane(Empty())
                                                                    ),
                                                                    (
                                                                        size: "100%",
                                                                        pane: Pane(QueueHeader())
                                                                    ),
                                                                ]
                                                            )
                                                        ),
                                                        (
                                                            size: "100%",
                                                            borders: "LEFT | RIGHT | BOTTOM",
                                                            border_symbols: Rounded,
                                                            pane: Split(
                                                                direction: Horizontal,
                                                                panes: [
                                                                    (
                                                                        size: "1",
                                                                        pane: Pane(Empty())
                                                                    ),
                                                                    (
                                                                        size: "100%",
                                                                        pane: Pane(Queue)
                                                                    ),
                                                                ]
                                                            )
                                                        ),
                                                    ],
                                                )
                                            ),
                                        ],
                                    ),
                                ),
                                (size: "35%", pane: Pane(Cava)),
                            ],
                        ),
                    ),
                    (
                        name: "Directories",
                        borders: "ALL",
                        border_symbols: Rounded,
                        pane: Split(
                            size: "100%",
                            direction: Vertical,
                            panes: [(pane: Pane(Directories), size: "100%", borders: "ALL", border_symbols: Rounded)],
                        )
                    ),
                    (
                        name: "Artists",
                        borders: "ALL",
                        border_symbols: Rounded,
                        pane: Split(
                            size: "100%",
                            direction: Vertical,
                            panes: [(pane: Pane(Artists), size: "100%", borders: "ALL", border_symbols: Rounded)],
                        )
                    ),
                    (
                        name: "Album Artists",
                        borders: "ALL",
                        border_symbols: Rounded,
                        pane: Split(
                            size: "100%",
                            direction: Vertical,
                            panes: [(pane: Pane(AlbumArtists), size: "100%", borders: "ALL", border_symbols: Rounded)],
                        )
                    ),
                    (
                        name: "Albums",
                        borders: "ALL",
                        border_symbols: Rounded,
                        pane: Split(
                            size: "100%",
                            direction: Vertical,
                            panes: [(pane: Pane(Albums), size: "100%", borders: "ALL", border_symbols: Rounded)],
                        )
                    ),
                    (
                        name: "Playlists",
                        borders: "ALL",
                        border_symbols: Rounded,
                        pane: Split(
                            size: "100%",
                            direction: Vertical,
                            panes: [(pane: Pane(Playlists), size: "100%", borders: "ALL", border_symbols: Rounded)],
                        )
                    ),
                    (
                        name: "Search",
                        borders: "ALL",
                        border_symbols: Rounded,
                        pane: Split(
                            size: "100%",
                            direction: Vertical,
                            panes: [(pane: Pane(Search), size: "100%", borders: "ALL", border_symbols: Rounded)],
                        )
                    ),
                ],
                cava: (
                    framerate: 60, // default 60
                    autosens: true, // default true
                    sensitivity: 100, // default 100
                    lower_cutoff_freq: 50, // not passed to cava if not provided
                    higher_cutoff_freq: 10000, // not passed to cava if not provided
                    input: (
                        method: Fifo,
                        source: "/tmp/mpd.fifo",
                        sample_rate: 44100,
                        channels: 2,
                        sample_bits: 16,
                    ),
                    smoothing: (
                        noise_reduction: 77, // default 77
                        monstercat: false, // default false
                        waves: false, // default false
                    ),
                    // this is a list of floating point numbers thats directly passed to cava
                    // they are passed in order that they are defined
                    eq: []
                ),
            )
        '';
    };
}
