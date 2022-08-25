RDEPENDS_${PN} += " \
    iptables \
"

RRECOMMENDS_${PN} += " \
    kernel-module-xt-tcpudp \
" 

do_install_append() {
    sed -i "s:/var/aos:/var:g" ${D}${systemd_system_unitdir}/aos-provfirewall.service
}
