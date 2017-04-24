# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils gnome2-utils xdg
DESCRIPTION="JS/HTML/CSS Terminal"
HOMEPAGE="https://hyper.is/"
SRC_URI="https://github.com/zeit/hyper/archive/${PV}.tar.gz -> hyper-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND="app-arch/xz-utils
	dev-util/electron:*
	net-libs/nodejs[npm]"
RDEPEND="app-arch/xz-utils
	dev-util/electron:*"
RESTRICT="mirror"

src_prepare() {
	einfo "Please create /usr/etc if you're using nodejs <=5.6.0,"
	einfo "as NPM otherwise tries to create it,violating the sandbox rules."
	einfo "See https://github.com/npm/npm/issues/11486"
	npm install || die "npm die failed"
	eapply_user
}

src_compile() {
	npm run pack || die "Npm packaging failed!"
}

src_install() {
	local destdir="/opt/Hyper"
	local insdir="dist/linux-unpacked"
	insinto $destdir
	doins -r $insdir/locales $insdir/resources
	doins	$insdir/blink_image_resources_200_percent.pak \
		$insdir/content_resources_200_percent.pak \
		$insdir/ui_resources_200_percent.pak \
		$insdir/views_resources_200_percent.pak \
		$insdir/content_shell.pak \
		$insdir/icudtl.dat \
		$insdir/natives_blob.bin \
		$insdir/snapshot_blob.bin \
		$insdir/libnode.so \
		$insdir/libffmpeg.so
	exeinto $destdir
	doexe $insdir/hyper
	dosym $destdir/hyper /usr/bin/hyper
	insinto /usr/share/icons
	doins -r "$FILESDIR"/hicolor
	insinto /usr/share/applications
	doins "$FILESDIR"/hyper.desktop
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
