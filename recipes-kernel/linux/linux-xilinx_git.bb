inherit kernel xilinx-kernel xilinx-utils
require recipes-kernel/linux/linux-dtb.inc

DESCRIPTION = "Linux kernel for Xilinx platforms"
COMPATIBLE_MACHINE = "(virtex4|virtex5|virtex5mb|spartan6-sp605|spartan6-lx9mb)"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

PR = "r16"
LINUX_VERSION = "2.6.37.1"
PV = "${LINUX_VERSION}+git${SRCPV}"
SRC_URI = "git://git.xilinx.com/linux-xlnx.git;protocol=git \
           file://defconfig"

XILINX_BOARD ?= "${@find_board(bb.data.getVar('XILINX_BSP_PATH', d, 1), d)}"
KERNEL_DEVICETREE = "${@device_tree(bb.data.getVar('TARGET_ARCH', d, 1), d)}"
KERNEL_DEVICETREE_microblazeel = "${@device_tree(bb.data.getVar('TARGET_CPU', d, 1), d)}"

S = "${WORKDIR}/git"
