# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
VALA_MIN_API_VERSION="0.26"
VALA_USE_DEPEND="vapigen"
inherit eutils autotools gnome2 gnome2-utils vala
DESCRIPTION="A game manager application for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Games"
SRC_URI="https://git.gnome.org/browse/${PN}/snapshot/${PN}-${PV}.tar.xz"
RESTRICT="mirror"
IUSE="static-libs nls"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-3"
RDEPEND=""
DEPEND="app-arch/libarchive
	app-misc/tracker
	${vala_depend}
	dev-libs/retro-gtk
	media-libs/grilo[vala]
	x11-libs/cairo
	nls? ( sys-devel/gettext )"

src_prepare() {
	vala_src_prepare
	eautoreconf
	gnome2_src_prepare
	eapply_user
}

src_configure() {
	gnome2_src_configure \
		--disable-schemas-compile \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_compile() {
	gnome2_src_compile
}

src_install() {
	gnome2_src_install
}

pkg_preinst() {
	gnome2_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_pkg_postrm
	gnome2_schemas_update
}
