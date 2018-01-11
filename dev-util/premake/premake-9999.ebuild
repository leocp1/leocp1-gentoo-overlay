# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils git-r3

DESCRIPTION="A makefile generation tool"
HOMEPAGE="https://premake.github.io/"
SRC_URI=''
EGIT_REPO_URI="https://github.com/premake/premake-core.git"

LICENSE="BSD"
SLOT=5
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	eapply_user
	git submodule init
	git submodule update
}

src_compile() {
	emake -f Bootstrap.mak linux
}

src_install() {
	dobin bin/release/premake5
}
