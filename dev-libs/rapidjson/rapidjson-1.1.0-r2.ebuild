# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A fast JSON parser/generator for C++ with both SAX/DOM style API"
HOMEPAGE="https://rapidjson.org/"

LICENSE="MIT"
IUSE="doc examples test"
SLOT="0"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/miloyip/rapidjson.git"
	inherit git-r3
else
	SRC_URI="https://github.com/miloyip/rapidjson/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/rapidjson-${PV}"
fi

# Deorder: arm: added arm flags to be able to build Kodi, not tested
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"

DEPEND="
	doc? ( app-doc/doxygen )
	test? (
		dev-cpp/gtest
		dev-util/valgrind
	)"
RDEPEND=""

PATCHES=(
	"${FILESDIR}/${P}-gcc-7.patch"
)

src_prepare() {
	cmake-utils_src_prepare

	sed -i -e 's|-Werror||g' CMakeLists.txt || die
	sed -i -e 's|-Werror||g' example/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DDOC_INSTALL_DIR="${EPREFIX}/usr/share/doc/${PF}"
		-DLIB_INSTALL_DIR="${EPREFIX}/usr/$(get_libdir)"
		-DRAPIDJSON_BUILD_DOC=$(usex doc)
		-DRAPIDJSON_BUILD_EXAMPLES=$(usex examples)
		-DRAPIDJSON_BUILD_TESTS=$(usex test)
		-DRAPIDJSON_BUILD_THIRDPARTY_GTEST=OFF
	)
	cmake-utils_src_configure
}
