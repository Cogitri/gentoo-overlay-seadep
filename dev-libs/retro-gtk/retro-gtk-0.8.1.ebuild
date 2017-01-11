# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
VALA_MIN_API_VERSION="0.26"
VALA_USE_DEPEND="vapigen"
AM_OPTS="--include-deps --gnu"
inherit eutils autotools vala
DESCRIPTION="Toolkit to write Gtk+ 3 based libretro frontends"
HOMEPAGE="https://git.gnome.org/browse/retro-gtk/"
SRC_URI="https://git.gnome.org/browse/retro-gtk/snapshot/retro-gtk-${PV}.tar.xz"
RESTRICT="mirror"
IUSE="+introspection nls static-libs"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-3"
RDEPEND=""
DEPEND="${vala_depend}
	dev-libs/gobject-introspection
	media-sound/pulseaudio
	x11-libs/gtk+:3
	"

src_prepare() {
	vala_src_prepare
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(use_enable introspection) \
		$(use_enable nls) \
		$(use_enable static-libs static)
}
src_compile() {
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
