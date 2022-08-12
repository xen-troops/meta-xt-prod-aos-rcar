SUMMARY = "Set of files to run a generic guest domain"
DESCRIPTION = "A config file, kernel, dtb and scripts for a guest domain"

PV = "0.1"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit externalsrc systemd

EXTERNALSRC_SYMLINKS = ""

SRC_URI = "\
    file://${XT_DOMF_CONFIG_NAME} \
    file://domf-vdevices.cfg \
    file://domf.service \
    file://domf-set-root \
"

FILES_${PN} = " \
    ${sysconfdir}/xen/domf.cfg \
    ${libdir}/xen/boot/domf.dtb \
    ${libdir}/xen/boot/linux-domf \
    ${libdir}/xen/bin/domf-set-root \
    ${systemd_system_unitdir}/domf.service \
"

SYSTEMD_SERVICE_${PN} = "domf.service"

do_install() {
    install -d ${D}${sysconfdir}/xen
    install -d ${D}${libdir}/xen/boot
    install -m 0644 ${WORKDIR}/${XT_DOMF_CONFIG_NAME} ${D}${sysconfdir}/xen/domf.cfg
    install -m 0644 ${S}/${XT_DOMF_DTB_NAME} ${D}${libdir}/xen/boot/domf.dtb
    install -m 0644 ${S}/Image ${D}${libdir}/xen/boot/linux-domf

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/domf.service ${D}${systemd_system_unitdir}

    install -d ${D}${libdir}/xen/bin
    install -m 0744 ${WORKDIR}/domf-set-root ${D}${libdir}/xen/bin
}
