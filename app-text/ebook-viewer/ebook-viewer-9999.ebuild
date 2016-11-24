# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI=6

inherit git-r3 eutils

DESCRIPTION="Simple Ebook viewer"

HOMEPAGE="https://github.com/michaldaniel/Ebook-Viewer"

SRC_URI=""
EGIT_REPO_URI="https://github.com/michaldaniel/Ebook-Viewer.git"
KEYWORDS="~amd64"

LICENSE="GPLv3"
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

pkg_postinst() {
	gtk-update-icon-cache -f /usr/share/icons/hicolor/
}
