# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=(python{2_7,3_4})

inherit distutils-r1

DESCRIPTION="A python client library for Google Play Services OAuth"
HOMEPAGE="https://github.com/simon-weber/gpsoauth"
SRC_URI="mirror://pypi/g/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/pycryptodomex-3.4[${PYTHON_USEDEP}]"
