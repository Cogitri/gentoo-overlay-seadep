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
IUSE=""
DEPEND=""
RDEPEND="|| (
		dev-java/oracle-jre-bin[javafx]
		dev-java/oracle-jdk-bin[javafx]
	)"
MY_PV=$(replace_all_version_separators '-')

src_unpack() {
	if [ ${A} != "" ]; then
		unpack ${A}
	fi
	S=${WORKDIR}/GeoGebra-Linux-Portable-${MY_PV}
}

src_install() {
	local destdir="/opt/${PN}"
	insinto $destdir
	doins -r geogebra
	exeinto $destdir/geogebra
	doexe geogebra/geogebra
	dosym $destdir/geogebra/geogebra /usr/bin/geogebra-bin
	make_desktop_entry geogebra-bin Geogebra "geogebra" Science
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
