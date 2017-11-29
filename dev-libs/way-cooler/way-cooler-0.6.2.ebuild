# Copyright 2017-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.1.4

EAPI=6

CRATES="
aho-corasick-0.5.3
bitflags-0.4.0
bitflags-0.5.0
bitflags-0.6.0
bitflags-0.7.0
bitflags-0.8.2
c_vec-1.2.1
cairo-rs-0.1.3
cairo-sys-rs-0.3.4
cfg-if-0.1.0
dbus-0.4.1
dbus-macros-0.0.6
dlib-0.3.1
dtoa-0.4.1
dummy-rustwlc-0.6.3
env_logger-0.3.5
fixedbitset-0.1.6
gcc-0.3.46
getopts-0.2.14
glib-0.1.3
glib-sys-0.3.4
gobject-sys-0.3.4
hlua-0.1.9
itoa-0.3.1
json_macro-0.1.1
kernel32-sys-0.2.2
lazy_static-0.2.8
libc-0.2.23
libloading-0.3.4
log-0.3.7
lua52-sys-0.0.4
memchr-0.1.11
nix-0.6.0
nix-0.8.1
num-traits-0.1.37
ordermap-0.2.10
petgraph-0.4.5
phf-0.7.21
phf_codegen-0.7.21
phf_generator-0.7.21
phf_shared-0.7.21
pkg-config-0.3.9
rand-0.3.15
regex-0.1.80
regex-syntax-0.3.9
rustc-serialize-0.3.24
rustc_version-0.1.7
rustwlc-0.6.2
semver-0.1.20
serde-0.9.15
serde_json-0.9.10
siphasher-0.2.2
target_build_utils-0.3.1
thread-id-2.0.0
thread_local-0.2.7
utf8-ranges-0.1.3
uuid-0.3.1
void-1.0.2
way-cooler-0.6.2
wayland-scanner-0.9.4
wayland-server-0.9.4
wayland-sys-0.6.0
wayland-sys-0.9.4
winapi-0.2.8
winapi-build-0.1.1
xml-rs-0.3.6
"

inherit cargo

DESCRIPTION="Customizeable Wayland compositor written in Rust"
HOMEPAGE="https://github.com/Immington-Industries/way-cooler/"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"
LICENSE="MIT" # Update to proper Gentoo format
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""
