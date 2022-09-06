FILESEXTRAPATHS_prepend := "${THISDIR}/initramfs-framework:"

SRC_URI += " \
    file://vardir \
"

PACKAGES += " \
    initramfs-module-vardir \
"

SUMMARY_initramfs-module-vardir = "mount RW /var directory"
RDEPENDS_initramfs-module-vardir = "${PN}-base"
FILES_initramfs-module-vardir = "/init.d/01-vardir"

do_install_append() {
    # vardir
    install -m 0755 ${WORKDIR}/vardir ${D}/init.d/01-vardir
}
