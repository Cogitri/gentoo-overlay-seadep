**Current build status:** [![Build Status](https://travis-ci.org/Keepco/gentoo-overlay-seadep.svg)](https://travis-ci.org/Keepco/gentoo-overlay-seadep)

Seadep-Overlay
==============

Overlay for Gentoo/Linux packages

The following packages are available in this overlay:

Easy-Ebook-Viewer - https://github.com/michaldaniel/Ebook-Viewer

Geogebra - https://www.geogebra.org/

Gitkraken - https://www.gitkraken.com

Gnome-Games - https://wiki.gnome.org/Apps/Games

Hyper - https://hyper.is/

Itch - https://github.com/itchio/itch

Retro-GTK - https://git.gnome.org/browse/retro-gtk/


## Warning
This overlay is not official but is available in layman's repository.

**Use ebuilds supplied in this repository on your own risk**. They've been tested on my own system setup (~amd64) and (most likely) tested on virtual systems (amd64 and x86).

## Installing

First time using layman? See https://wiki.gentoo.org/wiki/Layman

    layman -a seadep

Don't want to use layman? Copy seadep.conf to /etc/portage/repos.conf/seadep.conf and issue emerge --sync
