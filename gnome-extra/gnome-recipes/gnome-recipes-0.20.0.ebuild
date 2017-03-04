# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
VALA_MIN_API_VERSION="0.26"
VALA_USE_DEPEND="vapigen"
EGIT_REPO_URI="https://git.gnome.org/browse/recipes.git"
EGIT_MIN_CLONE_TYPE="single"
EGIT_COMMIT="0.20.0"
inherit eutils autotools git-r3 gnome2 gnome2-utils vala
DESCRIPTION="A game manager application for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Games"
SRC_URI=""
RESTRICT="mirror"
IUSE="autoar +introspection nls sound spell static-libs vala"
REQUIRED_USE=" vala? ( introspection )"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-3"
DEPEND="dev-libs/appstream-glib
	dev-libs/json-glib
	autoar? (
		!introspection? ( app-arch/gnome-autoar )
		introspection? ( app-arch/gnome-autoar[introspection] ) )
	introspection? (
			dev-libs/appstream-glib[introspection]
			dev-libs/gobject-introspection
			dev-libs/json-glib[introspection]
			>=x11-libs/gtk+-3.22.0[introspection] )
	!introspection? (
			dev-libs/appstream-glib
			dev-libs/json-glib
			>=x11-libs/gtk+-3.22.0 )
	nls? ( sys-devel/gettext )
	sound? ( media-libs/libcanberra )
	spell? (
		!introspection? ( app-text/gspell )
		introspection? ( app-text/gspell[introspection] ) )
	vala? ( $(vala_depend) )"
RDEPEND="${DEPEND}"

src_prepare() {
	if use vala; then
		vala_src_prepare
	fi
	eautoreconf
	gnome2_src_prepare
	eapply_user
}

src_configure() {
	gnome2_src_configure \
		--disable-schemas-compile \
		$(use_enable autoar) \
		$(use_enable nls ) \
		$(use_enable static-libs static ) \
		$(use_enable sound canberra ) \
		$(use_enable spell gspell) \
		$(use_enable introspection ) \
		$(use_enable vala )
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
