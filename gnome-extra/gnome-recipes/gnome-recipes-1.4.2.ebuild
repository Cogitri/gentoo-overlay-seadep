# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils gnome2 gnome2-utils
#EGIT_REPO_URI="https://git.gnome.org/browse/recipes.git"
#EGIT_MIN_CLONE_TYPE="single"
#EGIT_COMMIT="${PV}"
DESCRIPTION="A game manager application for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Games"
RESTRICT="mirror"
IUSE="autoar sound"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-3"
DEPEND="dev-libs/appstream-glib
	dev-libs/json-glib
	dev-util/meson
	dev-util/ninja
	>=x11-libs/gtk+-3.22.0
	autoar? ( app-arch/gnome-autoar )
	sound? ( media-libs/libcanberra )"
RDEPEND="${DEPEND}"

src_configure() {
	# Set meson parameters
	local params

	params="--prefix=/usr --libdir=lib --buildtype=plain"

	if use !autoar; then
		params="${params} -Dautoar=no"
	fi
	if use !sound; then
		params="${params} -Dcanberra=no"
	fi
	# Disable gspell for now
	params="${params} -Dgspell=no"

	meson ${params} build
}

src_compile() {
	ninja -v -C build || die "Ninja build failed!"
}

src_install() {
	# Fix desktop file, as it complains about being unable to import recipes otherwise
	if use !autoar; then
		sed -i "s/Exec=gnome-recipes %f/Exec=gnome-recipes/" build/data/org.gnome.Recipes.desktop
	fi
	# Remove this line, as it won't start via the desktop file otherwise
	sed -i "/DBusActivatable=true/d" build/data/org.gnome.Recipes.desktop
	DESTDIR="${D}" ninja -C build install || die "Ninja install failed"
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
