# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 qmake-utils gnome2-utils

DESCRIPTION="GameStream client for PCs"
HOMEPAGE="https://moonlight-stream.com/"
SRC_URI=""
EGIT_REPO_URI=https://github.com/moonlight-stream/${PN}.git

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libav"

DEPEND="dev-libs/openssl
	dev-qt/qtcore:5
	dev-qt/qtsvg:5
	media-libs/libsdl2
	media-libs/sdl2-ttf
	libav? ( media-video/libav )
	!libav? ( >=media-video/ffmpeg-4.0.0 )
	dev-qt/qtquickcontrols2:5
	x11-libs/libva
	x11-libs/libvdpau
	media-libs/portaudio"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5 PREFIX=/usr
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
