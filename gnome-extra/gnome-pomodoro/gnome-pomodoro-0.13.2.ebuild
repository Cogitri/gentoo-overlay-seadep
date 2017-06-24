# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION="0.26"
VALA_USE_DEPEND="vapigen"

inherit autotools gnome2 vala

DESCRIPTION="A Pomodoro timer for Gnome"
HOMEPAGE="http://gnomepomodoro.org/"
SRC_URI="https://github.com/codito/gnome-pomodoro/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="appindicator nls static-libs"

RDEPEND="dev-libs/appstream-glib
	dev-libs/glib
	dev-libs/gobject-introspection
	dev-libs/gobject-introspection-common
	dev-libs/dbus-glib
	dev-libs/libpeas
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	x11-libs/cairo
	>=x11-libs/gtk+-3.20.0
	appindicator? ( dev-libs/libappindicator:3 )"

DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/intltool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	vala_src_prepare
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
	$(use_enable nls) \
	$(use_enable static-libs static)
}

src_compile() {
	gnome2_src_compile
}

pkg_preinst() {
	gnome2_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
