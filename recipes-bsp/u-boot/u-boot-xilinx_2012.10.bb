require recipes-bsp/u-boot/u-boot.inc

DEFAULT_PREFERENCE = "1"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=1707d6db1d42237583f50183a5651ecb"

SRCREV_${PN} = "26786228acfdc0a02190a8d9ca9fcca51a5dcf28"

PV = "v2012.10"
PR = "r01"

# U-Boot source location
KBRANCH = "master"
SRC_URI = "git://git.xilinx.com/u-boot-xlnx.git;branch=${KBRANCH};protocol=git"

S = "${WORKDIR}/git"

do_deploy_append() {
	install ${S}/u-boot ${DEPLOYDIR}/u-boot-${MACHINE}.elf
}

FILESPATH = "${@base_set_filespath([ '${FILE_DIRNAME}/${PN}/${SOC_FAMILY}' ], d)}"

PACKAGE_ARCH = "${MACHINE_ARCH}"
PROVIDES += "u-boot"

COMPATIBLE_MACHINE = "(zynq-7)"
