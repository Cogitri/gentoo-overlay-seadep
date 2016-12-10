# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils

DESCRIPTION="A simple way to find and share indie games online for free."

HOMEPAGE="https://www.geogebra.org"

SRC_URI="https://www.geogebra.org/home/get/package/linux-port -> ${PN}.tar.bz2" 

KEYWORDS="~amd64 ~x86"

LICENSE="GPLv3"
SLOT="0"
RESTRICT="mirror"
RDEPEND=""



src_unpack() {
    	if [ "${A}" != "" ]; then
        	unpack ${A}
    	fi

	S=${WORKDIR}/GeoGebra-Linux-Portable-5-0-302-0
}


src_install() {

	local destdir="/opt/${PN}"

	insinto $destdir
	
	if use amd64; then
		doins -r geogebra jre1.7.0_45-x86_64
	elif use x86; then
		doins -r geogebra jre1.7.0_45-i686
	fi

	doins -r geogebra

	exeinto $destdir/geogebra
	doexe geogebra/geogebra	

	if use amd64; then
		exeinto $destdir/jre1.7.0_45-x86_64/bin
		doexe jre1.7.0_45-x86_64/bin/java
	elif use x86; then
		exeinto $destdir/jre1.7.0_45-i686/bin
		doexe jre1.7.0_45-x86_64/bin/java
	fi

	exeinto $destdir
	doexe geogebra-portable

	dosym $destdir/geogebra-portable /usr/bin/geogebra-portable
	make_desktop_entry geogebra-portable Geogebra \
		"geogebra" \
		Science
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
