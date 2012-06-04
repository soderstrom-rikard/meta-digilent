inherit xilinx-boot xilinx-utils
require recipes-bsp/u-boot/u-boot.inc

PR = "r16"
PV_virtex5    = "v2012.04.01"
PV_microblaze = "v2009.11"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM_virtex5 = "file://COPYING;md5=1707d6db1d42237583f50183a5651ecb"
LIC_FILES_CHKSUM_microblaze = "file://COPYING;md5=4c6cde5df68eff615d36789dc18edd3b"

# Virtex-5 src location
KBRANCH_virtex5 = "master"
SRC_URI_virtex5 = "git://git.denx.de/u-boot.git;branch=${KBRANCH};protocol=git"
SRCREV_${PN}_virtex5 = "415d386877df49eb051b85ef74fa59a16dc17c7d"

# Microblaze src location
KBRANCH_microblaze = "microblaze"
SRC_URI_microblaze = "git://git.xilinx.com/u-boot-xlnx.git;branch=${KBRANCH};protocol=git \
           file://ml405-add-uartlite-config-options.patch \
           file://ml405-replace-hardcode-macros-for-uartns550.patch \
           file://ml507-add-uartlite-config-options.patch \
           file://ml507-replace-hardcode-macros-for-uartns550.patch \
           file://microblaze-genric-add-spi-flash-config.patch \
           file://board-microblaze-monitor-flash-len.patch \
           file://cfi_flash-define-monitor_flash_len.patch"

XILINX_BOARD ?= "${@find_board(bb.data.getVar('XILINX_BSP_PATH', d, 1), d)}"

S = "${WORKDIR}/git"
