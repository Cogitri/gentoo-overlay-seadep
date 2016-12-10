# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils

DESCRIPTION="Mathematics software for geometry"

HOMEPAGE="https://www.geogebra.org"

SRC_URI="https://www.geogebra.org/home/get/package/linux-port -> ${PN}.tar.bz2" 

KEYWORDS="~amd64 ~x86"

LICENSE=" Creative Commons Attribution-NonCommercial-NoDerivs 3.0, GPL"
SLOT="0"
RESTRICT="mirror"
DEPEND=""
RDEPEND="virtual/jre"



src_unpack() {
    	if [ "${A}" != "" ]; then
        	unpack ${A}
    	fi

	S=${WORKDIR}/GeoGebra-Linux-Portable-5-0-302-0
}


src_install() {

	local destdir="/opt/"

	insinto $destdir
	
	doins -r geogebra

	exeinto $destdir/geogebra
	doexe geogebra/geogebra	

	dosym $destdir/geogebra/geogebra /usr/bin/geogebra
	make_desktop_entry geogebra Geogebra \
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
