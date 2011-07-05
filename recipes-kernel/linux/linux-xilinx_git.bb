inherit kernel xilinx-kernel xilinx-utils
require recipes-kernel/linux/linux-dtb.inc

DESCRIPTION = "Linux kernel for Xilinx platforms"
COMPATIBLE_MACHINE = "(virtex4|virtex5|spartan6-lx9mb)"

LICENSE = "GPL"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

PV = "2.6.37"
PR = "r11"

SRC_URI = "git://git.xilinx.com/linux-2.6-xlnx.git;protocol=git \
           file://linux-xilinx-do-not-use-OS-option.patch \
           file://kbuild-Fix-passing-Wno-options-to-gcc-4.4.patch \
		   file://defconfig"

XILINX_BOARD = "${@find_board(bb.data.getVar('XILINX_BSP_PATH', d, 1), d)}"
KERNEL_DEVICETREE = "${@device_tree(bb.data.getVar('TARGET_ARCH', d, 1), d)}"

S = "${WORKDIR}/git"
