require linux.inc

DESCRIPTION = "Linux kernel for Xilinx platforms"

COMPATIBLE_MACHINE = "virtex4|virtex5"
DEFAULT_PREFERENCE = "-1"
DEFAULT_PREFERENCE_virtex4 = "1"
DEFAULT_PREFERENCE_virtex5 = "1"

LICENSE = "GPL"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

TAG="xilinx_v2.6.37"
PV = "2.6.37"
PR = "r6"

SRCREV = "${TAG}"
SRC_URI = "git://git.xilinx.com/linux-2.6-xlnx.git;protocol=git \
           file://linux-xilinx-do-not-use-OS-option.patch \
		   file://defconfig"

inherit kernel xilinx-kernel

TARGET_BOARD = "${@map_target(bb.data.getVar('TARGET_ARCH', d, 1), d)}"
KERNEL_DEVICETREE_virtex4 = "arch/${ARCH}/boot/dts/virtex${TARGET_BOARD}.dts"
KERNEL_DEVICETREE_virtex5 = "arch/${ARCH}/boot/dts/virtex${TARGET_BOARD}.dts"

S = "${WORKDIR}/git"
