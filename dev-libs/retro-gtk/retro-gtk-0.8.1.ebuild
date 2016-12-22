# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils autotools

DESCRIPTION="Toolkit to write Gtk+ 3 based libretro frontends"

HOMEPAGE="https://git.gnome.org/browse/retro-gtk/"

SRC_URI="https://git.gnome.org/browse/retro-gtk/snapshot/retro-gtk-${PV}.tar.xz"
RESTRICT="mirror"
IUSE="static-libs"
KEYWORDS="~amd64"

SLOT="0"
LICENSE="GPL-3"
RDEPEND=""
DEPEND="=dev-lang/vala-0.32.1
	dev-libs/gobject-introspection
	media-sound/pulseaudio
	x11-libs/gtk+:3
	"

src_prepare() {
	#Set the used vala version to 0.32, as gentoo doesn't symlink the newest version to valac
	export VALAC="$(type -P valac-0.32)" 
	./autogen.sh #Not pretty, I'll try to make it manually soon
	eapply_user
}

src_compile() {
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install
} 


