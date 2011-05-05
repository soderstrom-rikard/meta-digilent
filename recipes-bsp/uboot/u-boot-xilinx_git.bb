require recipes-bsp/uboot/u-boot.inc
PR = "r10"
THISDIR := "${@os.path.dirname(bb.data.getVar('FILE', d, True))}"
FILESPATH =. "${@base_set_filespath(["${THISDIR}/files"], d)}:"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=4c6cde5df68eff615d36789dc18edd3b"

EXTRA_OEMAKE = "CROSS_COMPILE=${TARGET_PREFIX} OPTFLAGS='-O2'"

# Microblaze src location
SRCREV_microblaze = "97fb0720feec9a5b7b3ddc275e3880e5b6af74fe"
SRC_URI_microblaze = "git://git.xilinx.com/u-boot-xlnx.git;branch=microblaze;protocol=git"
SRC_URI_microblaze += " file://microblaze-genric-add-spi-flash-config.patch"

# Powerpc src location
SRC_URI = "git://git.xilinx.com/u-boot-xlnx.git;branch=master;protocol=git"
SRC_URI_powerpc += " file://uboot-remove-inline-qualifier-from-show_boot_progres.patch \
                     file://ml405-add-uartlite-config-options.patch \
                     file://ml405-replace-hardcode-macros-for-uartns550.patch \
                     file://ml507-add-uartlite-config-options.patch \
                     file://ml507-replace-hardcode-macros-for-uartns550.patch \
                    "

inherit xilinx-boot xilinx-utils

XILINX_BOARD = "${@find_board(bb.data.getVar('XILINX_BSP_PATH', d, 1), d)}"

S = "${WORKDIR}/git"
