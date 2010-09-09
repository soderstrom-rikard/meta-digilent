require ../meta/recipes-kernel/linux/linux.inc

DESCRIPTION = "Linux kernel for Xilinx platforms"

COMPATIBLE_MACHINE = "virtex4|virtex5"
DEFAULT_PREFERENCE = "-1"
DEFAULT_PREFERENCE_virtex4 = "1"
DEFAULT_PREFERENCE_virtex5 = "1"

PV = "2.6.34+git"
PR = "r1"

SRCREV = "17431547113100a3ae0a622b9f76ad17fb76eb56"
SRC_URI = "git://git.xilinx.com/linux-2.6-xlnx.git;protocol=git \
           file://xilinxfb-update-tft-comp.patch \
		   file://defconfig"

inherit kernel xilinx-bsp

TARGET_BOARD = "${@map_target(bb.data.getVar('TARGET_ARCH', d, 1), d)}"
KERNEL_DEVICETREE_virtex4 = "arch/${ARCH}/boot/dts/virtex${TARGET_BOARD}.dts"
KERNEL_DEVICETREE_virtex5 = "arch/${ARCH}/boot/dts/virtex${TARGET_BOARD}.dts"

S = "${WORKDIR}/git"

do_configure_prepend() {
    install -m 0644 ${WORKDIR}/defconfig ${S}/.config
}
