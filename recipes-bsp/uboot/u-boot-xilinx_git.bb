inherit xilinx-boot xilinx-utils
require recipes-bsp/uboot/u-boot.inc

PR = "r13"
PV = "v2009.11"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=4c6cde5df68eff615d36789dc18edd3b"

# Microblaze src location
SRCREV = "97fb0720feec9a5b7b3ddc275e3880e5b6af74fe"
SRC_URI = "git://git.xilinx.com/u-boot-xlnx.git;branch=microblaze;protocol=git \
           file://microblaze-genric-add-spi-flash-config.patch \
           file://board-microblaze-monitor-flash-len.patch \
           file://cfi_flash-define-monitor_flash_len.patch"

# Powerpc src location
SRCREV_powerpc = "d49297009f402a20dd59b21212975dd3d79ee6fd"
SRC_URI_powerpc = "git://git.xilinx.com/u-boot-xlnx.git;branch=master;protocol=git"
SRC_URI_powerpc += " file://uboot-remove-inline-qualifier-from-show_boot_progres.patch \
                     file://ml405-add-uartlite-config-options.patch \
                     file://ml405-replace-hardcode-macros-for-uartns550.patch \
                     file://ml507-add-uartlite-config-options.patch \
                     file://ml507-replace-hardcode-macros-for-uartns550.patch \
                    "

XILINX_BOARD = "${@find_board(bb.data.getVar('XILINX_BSP_PATH', d, 1), d)}"

S = "${WORKDIR}/git"
