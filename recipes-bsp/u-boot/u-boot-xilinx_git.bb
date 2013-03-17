inherit xilinx-boot xilinx-utils
require recipes-bsp/u-boot/u-boot.inc

DEFAULT_PREFERENCE = "-1"

PR = "r17"
PV_virtex-5   = "v2012.04.01"
PV_microblaze = "v2012.10"
PV_zynq-7     = "v2012.10"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM_virtex-5  = "file://COPYING;md5=1707d6db1d42237583f50183a5651ecb"
LIC_FILES_CHKSUM_spartan-6 = "file://COPYING;md5=4c6cde5df68eff615d36789dc18edd3b"
LIC_FILES_CHKSUM_zynq-7    = "file://COPYING;md5=4c6cde5df68eff615d36789dc18edd3b"
FILESPATH = "${@base_set_filespath([ '${FILE_DIRNAME}/${PN}/${SOC_FAMILY}' ], d)}"

# Virtex-5 src location
KBRANCH_virtex-5 = "master"
SRC_URI_virtex-5 = "git://git.denx.de/u-boot.git;branch=${KBRANCH};protocol=git"
SRCREV_${PN}_virtex-5 = "415d386877df49eb051b85ef74fa59a16dc17c7d"

# Spartan-6 src location
KBRANCH_spartan-6 = "master"
SRC_URI_spartan-6 = "git://git.xilinx.com/u-boot-xlnx.git;branch=${KBRANCH};protocol=git"
SRCREV_${PN}_spartan-6 = "26786228acfdc0a02190a8d9ca9fcca51a5dcf28"

# Zynq-7 src location
KBRANCH_zynq-7 = "master"
SRC_URI_zynq-7 = "git://git.xilinx.com/u-boot-xlnx.git;branch=${KBRANCH};protocol=git"
SRCREV_${PN}_zynq-7 = "26786228acfdc0a02190a8d9ca9fcca51a5dcf28"

XILINX_BOARD ?= "${@find_board(bb.data.getVar('XILINX_BSP_PATH', d, 1), d)}"

S = "${WORKDIR}/git"

do_deploy_append() {
	install ${S}/u-boot ${DEPLOYDIR}/u-boot-${MACHINE}.elf
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
PROVIDES += "u-boot"

COMPATIBLE_MACHINE = "(virtex-5|spartan-6|zynq-7)"