# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils gnome2-utils versionator xdg
DESCRIPTION="Mathematics software for geometry"
HOMEPAGE="https://www.geogebra.org"
SRC_URI="https://www.geogebra.org/home/get/package/linux-port -> ${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
LICENSE="CC-BY-ND-3.0 GPL-3"
SLOT="0"
RESTRICT="mirror"
IUSE="binary"
DEPEND=""
RDEPEND="!binary? ( virtual/jre )"
MY_PV=$(replace_all_version_separators '-')

src_unpack() {
	if [ ${A} != "" ]; then
		unpack ${A}
	fi
	S=${WORKDIR}/GeoGebra-Linux-Portable-${MY_PV}
}

src_install() {
	if use binary; then
		local destdir="/opt/${PN}"
		insinto $destdir
		if use amd64; then
			doins -r geogebra jre1.7.0_45-x86_64
			exeinto $destdir/jre1.7.0_45-x86_64/bin
			doexe jre1.7.0_45-x86_64/bin/java
		elif use x86; then
			doins -r geogebra jre1.7.0_45-i686
			exeinto $destdir/jre1.7.0_45-i686/bin
			doexe jre1.7.0_45-i686/bin/java
		fi
		exeinto $destdir/
		doexe geogebra-portable
		dosym $destdir/geogebra-portable /usr/bin/geogebra-portable
		make_desktop_entry geogebra-portable Geogebra \
		"geogebra" \
		Science
	else
		local destdir="/opt/${PN}"
		insinto $destdir
		dosym $destdir/geogebra/geogebra /usr/bin/geogebra-bin
		make_desktop_entry geogebra-bin Geogebra "geogebra" Science
	fi

	doins -r geogebra
	exeinto $destdir/geogebra
	doexe geogebra/geogebra
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
