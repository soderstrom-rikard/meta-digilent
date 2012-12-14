inherit kernel xilinx-kernel xilinx-utils
require recipes-kernel/linux/linux-xilinx.inc

DEFAULT_PREFERENCE = "-1"

KBRANCH = "master"

LINUX_VERSION ?= "3.3.0"
SRCREV_pn-${PN} = "ed63a4d76efadcb68f5776e4244766ffea226cc4"
FILESPATH = "${@base_set_filespath([ '${FILE_DIRNAME}/${PN}/${SOC_FAMILY}' ], d)}"

PR = "r17"
PV = "${LINUX_VERSION}+git-${SRCREV}"

SRC_URI = "git://git.xilinx.com/linux-xlnx.git;protocol=git;branch=${KBRANCH} \
           file://defconfig"

XILINX_BOARD ?= "${@find_board(bb.data.getVar('XILINX_BSP_PATH', d, 1), d)}"
KERNEL_DEVICETREE_microblazeel = "${@device_tree(bb.data.getVar('TARGET_CPU', d, 1), d)}"

COMPATIBLE_MACHINE = "(virtex4|virtex-5|virtex5mb|spartan6-sp605|spartan6-lx9mb)"
