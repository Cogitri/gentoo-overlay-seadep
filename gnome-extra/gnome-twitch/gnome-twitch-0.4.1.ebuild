# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils fdo-mime meson

DESCRIPTION="Enjoy Twitch on your GNU/Linux desktop"
HOMEPAGE="http://gnome-twitch.vinszent.com/"
SRC_URI="https://github.com/vinszent/gnome-twitch/archive/v${PV}.tar.gz -> ${P}.tar.gz "

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DOCS="README.md CHANGELOG.md CONTRIBUTING.md"
IUSE="gst-cairo gst-opengl gst-clutter mpv"

RDEPEND=">=x11-libs/gtk+-3.20
		net-libs/libsoup
		dev-libs/json-glib
		net-libs/webkit-gtk
		gst-cairo? (
			media-libs/gstreamer
			media-plugins/gst-plugins-libav
			media-libs/gst-plugins-base
			media-libs/gst-plugins-good
			media-libs/gst-plugins-bad
		)
		gst-opengl? (
			media-libs/gstreamer
			media-plugins/gst-plugins-libav
			media-libs/gst-plugins-base
			media-libs/gst-plugins-good
			media-libs/gst-plugins-bad
		)
		gst-clutter? (
			media-libs/gstreamer
			media-plugins/gst-plugins-libav
			media-libs/gst-plugins-base
			media-libs/gst-plugins-good
			media-libs/gst-plugins-bad
			>=media-libs/clutter-gst-3.0
			>=media-libs/clutter-gtk-1.0
		)
		mpv? (
			media-video/mpv[libmpv]
		)
		dev-libs/libpeas
		dev-libs/gobject-introspection"

src_configure() {
	# Set meson parameters
	local backends

	if use gst-cairo; then
		backends+="gstreamer-cairo"
	fi
	if use gst-clutter; then
		if [ -z "$backends" ]
		then
			backends+="gstreamer-clutter"
		else
			backends+=",gstreamer-clutter"
		fi
	fi
	if use gst-opengl; then
		if [ -z "$backends" ]
		then
			backends+="gstreamer-opengl"
		else
			backends+=",gstreamer-opengl"
		fi
	fi
	if use mpv; then
		if [ -z "$backends" ]
		then
			backends+="mpv-opengl"
		else
			backends+=",mpv-opengl"
		fi
	fi

	emesonargs="-Dbuild-player-backends="${backends}" -Ddo-post-install=false -Db_lundef=false"

	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_test() {
	meson_src_test
}

src_install() {
	meson_src_install
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
	gnome2_schemas_update
}
