# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6

inherit git-r3 eutils gnome2-utils

DESCRIPTION="Simple Ebook viewer"

HOMEPAGE="https://github.com/michaldaniel/Ebook-Viewer"

SRC_URI=""
EGIT_REPO_URI="https://github.com/michaldaniel/Ebook-Viewer.git"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="net-libs/webkit-gtk[introspection]
	x11-libs/gtk+[introspection]
	dev-python/pygobject[python_targets_python3_4]
	dev-lang/python:3.4"

src_prepare() {
	eapply_user
	epatch "${FILESDIR}/patches/${P}-portage.patch"
}
src_install() {
	emake DESTDIR="${D}" install || die "Install failed!"
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
