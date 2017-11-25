***Currently this overlay isn't really actively maintained, since I switched over to Exherbo. In case you want to maintain one of the packages in this overlay in your own just copy it over ( would be nice if you opened an issue about it too, so that I drop mine)***

**Current build status:** [![Build Status](https://travis-ci.org/Cogitri/gentoo-overlay-seadep.svg)](https://travis-ci.org/Cogitri/gentoo-overlay-seadep)

Seadep-Overlay
==============

Overlay for Gentoo/Linux packages

The following packages are available in this overlay:

Easy-Ebook-Viewer - https://github.com/michaldaniel/Ebook-Viewer

~~Gitkraken - https://www.gitkraken.com~~ ( Moved to the [frabjous overlay](https://github.com/csmk/frabjous) )

~~Gmusicapi - https://github.com/simon-weber/gmusicapi~~ ( Moved to the [frabjous overlay](https://github.com/csmk/frabjous) )

~~Gmusicproxy - https://github.com/diraimondo/gmusicproxy~~ ( Moved to the [frabjous overlay](https://github.com/csmk/frabjous) )

Gnome-Games - https://wiki.gnome.org/Apps/Games

Gnome-Recipes - https://wiki.gnome.org/Apps/Recipes

Gnome-Twitch - https://wiki.gnome.org/Apps/GnomeTwitch

~~Gpsoauth - https://github.com/simon-weber/gpsoauth~~ ( Moved to the [frabjous overlay](https://github.com/csmk/frabjous) )

Hyper - https://hyper.is/

Itch - https://github.com/itchio/itch

~~PyCryptodomex - https://github.com/Legrandin/pycryptodome~~ ( Moved to the [frabjous overlay](https://github.com/csmk/frabjous) )

~~Rambox - http://rambox.pro/~~ ( Moved to the [frabjous overlay](https://github.com/csmk/frabjous) )

Retro-GTK - https://git.gnome.org/browse/retro-gtk/

~~Validictory - https://github.com/jamesturk/validictory~~ ( Moved to the [frabjous overlay](https://github.com/csmk/frabjous) )


## Warning
This overlay is not official but is available in layman's repository. I try to keep the ebuilds up to date, but please open a issue if I missed an update

**Use ebuilds supplied in this repository on your own risk**. They've been tested on my own system setup (~amd64) and (most likely) tested on virtual systems (amd64 and x86).

## Installing

First time using layman? See https://wiki.gentoo.org/wiki/Layman

    layman -a seadep

Don't want to use layman? Copy seadep.conf to /etc/portage/repos.conf/seadep.conf and issue emerge --sync
