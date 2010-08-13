require ../meta/packages/uboot/u-boot.inc
PR = "r0"

# Prefered u-boot from mainstream since has generic support for
# ppc405, ppc440
SRC_URI = "git://git.xilinx.com/u-boot-xlnx.git;protocol=git"
SRCREV = "26e999650cf77c16f33c580abaadab2532f5e8b2"

inherit xilinx-bsp

TARGET_BOARD = "${@map_target(bb.data.getVar('TARGET_ARCH', d, 1), d)}"
UBOOT_TARGET = "${@uboot_target(bb.data.getVar('TARGET_ARCH', d, 1), d)}"
export UBOOT_MACHINE = "${@uboot_machine(bb.data.getVar('TARGET_ARCH', d, 1), d)}"

S = "${WORKDIR}/git"
