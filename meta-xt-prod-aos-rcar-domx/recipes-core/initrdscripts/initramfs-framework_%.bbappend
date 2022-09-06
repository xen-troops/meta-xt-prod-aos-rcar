FILESEXTRAPATHS_prepend := "${THISDIR}/initramfs-framework:"

SRC_URI += " \
    file://vardir \
    file://machineid \
"

PACKAGES += " \
    initramfs-module-vardir \
    initramfs-module-machineid \
"

SUMMARY_initramfs-module-vardir = "mount RW /var directory"
RDEPENDS_initramfs-module-vardir = "${PN}-base"
FILES_initramfs-module-vardir = "/init.d/01-vardir"

SUMMARY_initramfs-module-machineid = "bind /etc/machine-id to /var/machine-id"
RDEPENDS_initramfs-module-machineid = "${PN}-base initramfs-module-vardir"
FILES_initramfs-module-machineid = "/init.d/96-machineid"

do_install_append() {
    # vardir
    install -m 0755 ${WORKDIR}/vardir ${D}/init.d/01-vardir

    # machineid
    install -m 0755 ${WORKDIR}/machineid ${D}/init.d/96-machineid
}
