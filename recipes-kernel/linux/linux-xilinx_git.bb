SUMMARY = "Xilinx Linux Kernel, bleeding edge version"
DESCRIPTION = "Xilinx Linux Kernel for Xilinx FPGA development platforms, bleeding edge version."
AUTHOR = "Elvis Dowson <elvis.dowson@gmail.com>"
HOMEPAGE = "http://git.xilinx.com/?p=linux-xlnx.git;a=summary"
SECTION = "kernel"
LICENSE = "GPLv2"

require recipes-kernel/linux/linux-yocto.inc

DEFAULT_PREFERENCE = "-1"

LINUX_VERSION ?= "3.6.0"
LINUX_VERSION_EXTENSION = "-xilinx"

SRCREV_pn-${PN} = "c0265c7446eeedb19faae79ca1806952fe360f50"

PV = "${LINUX_VERSION}+git-${SRCREV}"
PR = "r18"

KBRANCH = "master-next"
SRC_URI = "git://git.xilinx.com/linux-xlnx.git;protocol=git;branch=${KBRANCH} \
           file://defconfig"

FILESPATH = "${@base_set_filespath([ '${FILE_DIRNAME}/${PN}/${SOC_FAMILY}' ], d)}"

COMPATIBLE_MACHINE = "(zynq-7)"
