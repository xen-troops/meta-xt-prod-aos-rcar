# Enable RO rootfs
IMAGE_FEATURES_append = " read-only-rootfs"

IMAGE_INSTALL_append = " \
    bash \
    domu-network \
"

# System components
IMAGE_INSTALL_append = " \
    openssh \
"

# Aos components
IMAGE_INSTALL_append = " \
    aos-iamanager \
    aos-communicationmanager \
    aos-servicemanager \
"
