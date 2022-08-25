FILESEXTRAPATHS_prepend := "${THISDIR}/optee-os:"

SRC_URI = "git://github.com/OP-TEE/optee_os.git"
# optee-os 3.18.0
SRCREV = "1ee647035939e073a2e8dddb727c0f019cc035f1"

DEPENDS += "python3-cryptography-native"
