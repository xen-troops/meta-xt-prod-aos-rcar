# Enable RO rootfs
IMAGE_FEATURES_append = " read-only-rootfs"

IMAGE_INSTALL_append = " \
    xen \
    xen-tools-devd \
    xen-tools-scripts-network \
    xen-tools-scripts-block \
    xen-tools-xenstore \
    xen-network \
    dnsmasq \
    optee-os \
    block \
"

IMAGE_INSTALL_remove = "optee-client"

# System components
IMAGE_INSTALL_append = " \
    openssh \
"
