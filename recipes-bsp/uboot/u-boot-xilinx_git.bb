require recipes-bsp/uboot/u-boot.inc
PR = "r9"
THISDIR := "${@os.path.dirname(bb.data.getVar('FILE', d, True))}"
FILESPATH =. "${@base_set_filespath(["${THISDIR}/files"], d)}:"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=4c6cde5df68eff615d36789dc18edd3b"

EXTRA_OEMAKE = "CROSS_COMPILE=${TARGET_PREFIX} OPTFLAGS='-O2'"
BRANCH="master"
#TAG="e094f2479ea339d7f48b6826f06f0be4984d9a98"
TAG="d49297009f402a20dd59b21212975dd3d79ee6fd"
SRC_URI = "git://git.xilinx.com/u-boot-xlnx.git;branch=${BRANCH};protocol=git \
           file://uboot-remove-inline-qualifier-from-show_boot_progres.patch \
           file://ml405-add-uartlite-config-options.patch \
           file://ml405-replace-hardcode-macros-for-uartns550.patch \
           file://ml507-add-uartlite-config-options.patch \
           file://ml507-replace-hardcode-macros-for-uartns550.patch \
          "
SRCREV = "${TAG}"

inherit xilinx-boot xilinx-utils

XILINX_BOARD = "${@find_board(bb.data.getVar('XILINX_BSP_PATH', d, 1), d)}"

S = "${WORKDIR}/git"
