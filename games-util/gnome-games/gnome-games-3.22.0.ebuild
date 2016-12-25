# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils autotools gnome2-utils xdg

DESCRIPTION="A game manager application for GNOME"

HOMEPAGE="https://wiki.gnome.org/Apps/Games"

SRC_URI="https://git.gnome.org/browse/${PN}/snapshot/${PN}-${PV}.tar.xz"
RESTRICT="mirror"
IUSE="static-libs"
KEYWORDS="~amd64"

SLOT="0"
LICENSE="GPL-3"
RDEPEND=""
DEPEND="app-arch/libarchive
	app-misc/tracker
	=dev-lang/vala-0.32.1
	dev-libs/retro-gtk
	media-libs/grilo[vala]
	x11-libs/cairo"

src_prepare() {
	#Set the used vala version to 0.32, as gentoo doesn't symlink the newest version to valac
	export VALAC="$(type -P valac-0.32)"
	eautoreconf
	eapply_user
}

src_compile() {
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_preinst() {
	gnome2_icon_savelist
	xdg_pkg_preinst
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_pkg_postrm
}

