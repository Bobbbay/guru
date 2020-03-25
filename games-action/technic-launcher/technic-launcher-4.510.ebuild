# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="Minecraft launcher for community-made modpacks on the Technic Platform"
HOMEPAGE="https://www.technicpack.net/"
SRC_URI="http://launcher.technicpack.net/launcher${PV:0:1}/${PV:2}/TechnicLauncher.jar -> ${P}.jar
	https://www.technicpack.net/favicon.ico -> ${PN}.ico"

KEYWORDS="~amd64 ~x86"
LICENSE="technic"
SLOT="0"

RESTRICT="mirror"

BDEPEND="media-gfx/imagemagick"

RDEPEND="virtual/jre:1.8"

S="${WORKDIR}"

src_unpack() {
	# do not unpack jar file
	cp "${DISTDIR}/${PN}.ico" "${S}" || die
}

src_compile() {
	convert ${PN}.ico ${PN}.png || die
}

src_install() {
	dodir /opt/${PN}
	insinto /opt/${PN}/
	newins "${DISTDIR}/${P}.jar" ${PN}.jar

	insinto /opt/bin/
	doins "${FILESDIR}/${PN}"
	fperms +x /opt/bin/${PN}

	newicon -s 16x16 ${PN}-0.png ${PN}.png
	newicon -s 32x32 ${PN}-1.png ${PN}.png
	newicon -s 48x48 ${PN}-2.png ${PN}.png
	make_desktop_entry ${PN} "Technic Launcher" ${PN} Game
}