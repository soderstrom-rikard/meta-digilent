# This recipe allows to build an U-Boot for the ZX3-PM3 and ZE7000
# boards
# (C) NetModule 2014

require recipes-bsp/u-boot/u-boot.inc

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=1707d6db1d42237583f50183a5651ecb"

PR = "r0"
PV = "2013.04-git"
SRC_URI = "git://github.com/netmodule/uboot-ze7000.git;protocol=https"

SRCREV = "${AUTOREV}"

UBOOT_MACHINE_zx3-pm3-zynq7 = "zx3_pm3"
UBOOT_MACHINE_ze7000_zynq7 = "zx3_ze7000"

S = "${WORKDIR}/git"

# Also deploy u-boot elf file with same file format as bin file
# Based on u-boox-extra.inc from meta-xilinx
UBOOTXTENSION ?= "-${MACHINE}"
SRC_ELF ?= "u-boot"
DEST_ELF ?= "u-boot${UBOOTXTENSION}-${PV}-${PR}.elf"
ELF_SYMLINK ?= "u-boot${UBOOTXTENSION}.elf"
do_deploy_append() {
	install ${S}/${SRC_ELF} ${DEPLOYDIR}/${DEST_ELF}

	cd ${DEPLOYDIR}
	rm -f ${SRC_ELF} ${ELF_SYMLINK}
	ln -sf ${DEST_ELF} ${ELF_SYMLINK}
	ln -sf ${DEST_ELF} ${SRC_ELF}.elf
}

PACKAGE_ARCH = "${MACHINE_ARCH}"