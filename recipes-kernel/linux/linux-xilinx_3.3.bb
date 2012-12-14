inherit kernel xilinx-kernel xilinx-utils
require recipes-kernel/linux/linux-xilinx.inc

DEFAULT_PREFERENCE = "1"

KBRANCH = "master"

LINUX_VERSION ?= "3.3.0"
SRCREV_pn-${PN} = "1e92da8e3a66b051766b1be57be67e2bff11e19d"
FILESPATH = "${@base_set_filespath([ '${FILE_DIRNAME}/${PN}-${PV}/${SOC_FAMILY}' ], d)}"

PR = "r00"

SRC_URI = "git://git.xilinx.com/linux-xlnx.git;protocol=git;branch=${KBRANCH} \
           file://0001-Xilinx-Update-IP-Core-support-for-Xilinx-ISE-14.1.patch \
           file://0002-virtex440-ml507.dts-Update-device-tree-file-using-Xi.patch \
           file://0003-xilinxfb-Fix-regression-in-call-to-XPS-TFT-controlle.patch \
           file://defconfig"

# Support for binary device tree generation
XILINX_BOARD ?= "${@find_board(bb.data.getVar('XILINX_BSP_PATH', d, 1), d)}"
KERNEL_DEVICETREE_microblazeel = "${@device_tree(bb.data.getVar('TARGET_CPU', d, 1), d)}"

COMPATIBLE_MACHINE = "(virtex4|virtex-5|virtex5mb|spartan6-sp605|spartan6-lx9mb)"
