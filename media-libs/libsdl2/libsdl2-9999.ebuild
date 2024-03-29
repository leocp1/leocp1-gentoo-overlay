# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# TODO: convert FusionSound #484250

EAPI=6
inherit autotools flag-o-matic toolchain-funcs ltprune multilib-minimal mercurial

DESCRIPTION="Simple Direct Media Layer"
HOMEPAGE="http://www.libsdl.org"
EHG_REPO_URI="https://hg.libsdl.org/SDL/"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""

IUSE="cpu_flags_x86_3dnow alsa altivec custom-cflags dbus fusionsound gles haptic +joystick cpu_flags_x86_mmx nas opengl oss pulseaudio +sound cpu_flags_x86_sse cpu_flags_x86_sse2 static-libs +threads tslib udev +video vulkan wayland X xinerama xscreensaver"
IUSE_SDL="loadso"

for iuse_sdl in ${IUSE_SDL}; do
	IUSE="${IUSE} sdl_${iuse_sdl}"
done

REQUIRED_USE="
	alsa? ( sound )
	fusionsound? ( sound )
	gles? ( video )
	kernel_Winnt? ( sdl_loadso )
	nas? ( sound )
	opengl? ( video )
	vulkan? ( video sdl_loadso )
	pulseaudio? ( sound )
	wayland? ( gles )
	xinerama? ( X )
	xscreensaver? ( X )"

RDEPEND="
	alsa? ( >=media-libs/alsa-lib-1.0.27.2[${MULTILIB_USEDEP}] )
	dbus? ( >=sys-apps/dbus-1.6.18-r1[${MULTILIB_USEDEP}] )
	fusionsound? ( || ( >=media-libs/FusionSound-1.1.1 >=dev-libs/DirectFB-1.7.1[fusionsound] ) )
	gles? ( >=media-libs/mesa-9.1.6[${MULTILIB_USEDEP},gles2] )
	nas? ( >=media-libs/nas-1.9.4[${MULTILIB_USEDEP}] )
	opengl? (
		>=virtual/opengl-7.0-r1[${MULTILIB_USEDEP}]
		>=virtual/glu-9.0-r1[${MULTILIB_USEDEP}]
	)
	pulseaudio? ( >=media-sound/pulseaudio-2.1-r1[${MULTILIB_USEDEP}] )
	tslib? ( >=x11-libs/tslib-1.0-r3[${MULTILIB_USEDEP}] )
	udev? ( >=virtual/libudev-208:=[${MULTILIB_USEDEP}] )
	vulkan? ( >=media-libs/vulkan-loader-1.0.0.0:=[${MULTILIB_USEDEP}] )
	wayland? (
		>=dev-libs/wayland-1.0.6[${MULTILIB_USEDEP}]
		>=media-libs/mesa-9.1.6[${MULTILIB_USEDEP},egl,gles2,wayland]
		>=x11-libs/libxkbcommon-0.2.0[${MULTILIB_USEDEP}]
	)
	X? (
		>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXcursor-1.1.14[${MULTILIB_USEDEP}]
		>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXi-1.7.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXrandr-1.4.2[${MULTILIB_USEDEP}]
		>=x11-libs/libXt-1.1.4[${MULTILIB_USEDEP}]
		>=x11-libs/libXxf86vm-1.1.3[${MULTILIB_USEDEP}]
		xinerama? ( >=x11-libs/libXinerama-1.1.3[${MULTILIB_USEDEP}] )
		xscreensaver? ( >=x11-libs/libXScrnSaver-1.2.2-r1[${MULTILIB_USEDEP}] )
	)"
DEPEND="${RDEPEND}
	X? (
		>=x11-proto/xextproto-7.2.1-r1[${MULTILIB_USEDEP}]
		>=x11-proto/xproto-7.0.24[${MULTILIB_USEDEP}]
	)
	virtual/pkgconfig"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/SDL2/SDL_config.h
)

PATCHES=(
	# https://bugzilla.libsdl.org/show_bug.cgi?id=1431
	"${FILESDIR}"/${PN}-2.0.6-static-libs.patch
)

src_prepare() {
	default
	sed -i -e 's/configure.in/configure.ac/' Makefile.in || die
	mv configure.{in,ac} || die
	AT_M4DIR="/usr/share/aclocal acinclude" eautoreconf
}

multilib_src_configure() {
	use custom-cflags || strip-flags

	# sorted by `./configure --help`
	local myeconfargs=(
		$(use_enable static-libs static)
		--enable-atomic
		$(use_enable sound audio)
		$(use_enable video)
		--enable-render
		--enable-events
		$(use_enable joystick)
		$(use_enable haptic)
		--enable-power
		--enable-filesystem
		$(use_enable threads)
		--enable-timers
		--enable-file
		$(use_enable sdl_loadso loadso)
		--enable-cpuinfo
		--enable-assembly
		$(use_enable cpu_flags_x86_sse ssemath)
		$(use_enable cpu_flags_x86_mmx mmx)
		$(use_enable cpu_flags_x86_3dnow 3dnow)
		$(use_enable cpu_flags_x86_sse sse)
		$(use_enable cpu_flags_x86_sse2 sse2)
		$(use_enable altivec)
		$(use_enable oss)
		$(use_enable alsa)
		--disable-alsa-shared
		--disable-esd
		$(use_enable pulseaudio)
		--disable-pulseaudio-shared
		--disable-arts
		$(use_enable nas)
		--disable-nas-shared
		--disable-sndio
		--disable-sndio-shared
		$(use_enable sound diskaudio)
		$(use_enable sound dummyaudio)
		$(use_enable wayland video-wayland)
		--disable-wayland-shared
		--disable-video-mir
		$(use_enable X video-x11)
		--disable-x11-shared
		$(use_enable X video-x11-xcursor)
		$(use_enable X video-x11-xdbe)
		$(use_enable xinerama video-x11-xinerama)
		$(use_enable X video-x11-xinput)
		$(use_enable X video-x11-xrandr)
		$(use_enable xscreensaver video-x11-scrnsaver)
		$(use_enable X video-x11-xshape)
		$(use_enable X video-x11-vm)
		--disable-video-cocoa
		--disable-video-directfb
		$(multilib_native_use_enable fusionsound)
		--disable-fusionsound-shared
		$(use_enable video video-dummy)
		$(use_enable opengl video-opengl)
		--disable-video-opengles1
		$(use_enable gles video-opengles2)
		$(use_enable vulkan video-vulkan)
		$(use_enable udev libudev)
		$(use_enable dbus)
		--disable-ibus
		$(use_enable tslib input-tslib)
		--disable-directx
		--disable-rpath
		--disable-render-d3d
		$(use_with X x)
	)

	ECONF_SOURCE=${S} econf "${myeconfargs[@]}"
}

multilib_src_compile() {
	emake V=1
}

multilib_src_install() {
	emake DESTDIR="${D}" install
}

multilib_src_install_all() {
	prune_libtool_files
	dodoc {BUGS,CREDITS,README,README-SDL,TODO,WhatsNew}.txt docs/README*.md
}
