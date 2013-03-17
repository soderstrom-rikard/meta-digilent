SUMMARY = "Xilinx Linux Kernel 3.6"
DESCRIPTION = "Xilinx Linux Kernel 3.6 for Xilinx FPGA development platforms."
AUTHOR = "Elvis Dowson <elvis.dowson@gmail.com>"
HOMEPAGE = "http://git.xilinx.com/?p=linux-xlnx.git;a=summary"
SECTION = "kernel"
LICENSE = "GPLv2"

require recipes-kernel/linux/linux-yocto.inc

DEFAULT_PREFERENCE = "1"

LINUX_VERSION ?= "3.6.0"
LINUX_VERSION_EXTENSION = "-xilinx"

SRCREV_pn-${PN} = "04d9378881401e71f83b8b4fea0abd71d33b4052"

PR = "r01"

KBRANCH = "master"
SRC_URI = "git://git.xilinx.com/linux-xlnx.git;protocol=git;branch=${KBRANCH} \
           file://defconfig"

FILESPATH = "${@base_set_filespath([ '${FILE_DIRNAME}/${PN}-${PV}/${SOC_FAMILY}' ], d)}"

COMPATIBLE_MACHINE = "(zynq-7)"
