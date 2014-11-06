
FILESEXTRAPATHS_prepend := "${THISDIR}/linux-xlnx/${LINUX_VERSION}:"

SRC_URI_append_zc702-base-trd-zynq7 += "file://defconfig"
SRC_URI_append_zc706-pcie-trd-zynq7 += "file://defconfig"
