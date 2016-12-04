# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils

DESCRIPTION="A simple way to find and share indie games online for free."

HOMEPAGE="https://itch.io/"

SRC_URI="https://github.com/itchio/itch/releases/download/v${PV}/itch-${PV}-amd64.tar.xz"

KEYWORDS="~amd64"

LICENSE="GPLv3"
SLOT="0"

RDEPEND=""

S=${WORKDIR}/itch-${PV}-amd64

src_install() {
	local destdir="/opt/${PN}"

	insinto $destdir
	doins -r locales resources
	doins \
		blink_image_resources_200_percent.pak \
		content_resources_200_percent.pak \
		ui_resources_200_percent.pak \
		views_resources_200_percent.pak \
		content_shell.pak \
		icudtl.dat \
		natives_blob.bin \
		snapshot_blob.bin \
		libnode.so \
		libffmpeg.so

	exeinto $destdir
	doexe itch

	doins $FILESDIR/ico/itch.png
	dosym $destdir/itch /usr/bin/itch
	make_desktop_entry itch Itch \
		"/opt/itch/itch.png" \
		Network
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
