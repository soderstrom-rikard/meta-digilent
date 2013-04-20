SUMMARY = "Xilinx Linux Kernel 3.3"
DESCRIPTION = "Xilinx Linux Kernel 3.3 for Xilinx FPGA development platforms."
AUTHOR = "Elvis Dowson <elvis.dowson@gmail.com>"
HOMEPAGE = "http://git.xilinx.com/?p=linux-xlnx.git;a=summary"
SECTION = "kernel"
LICENSE = "GPLv2"

inherit kernel xilinx-kernel xilinx-utils
require recipes-kernel/linux/linux-xilinx.inc

DEFAULT_PREFERENCE = "1"

LINUX_VERSION ?= "3.3.0"
LINUX_VERSION_EXTENSION = "-xilinx"

SRCREV = "1e92da8e3a66b051766b1be57be67e2bff11e19d"

PR = "r02"

KBRANCH = "master"
SRC_URI = "git://git.xilinx.com/linux-xlnx.git;protocol=git;branch=${KBRANCH} \
           file://0001-Xilinx-Update-IP-Core-support-for-Xilinx-ISE-14.1.patch \
           file://0002-virtex440-ml507.dts-Update-device-tree-file-using-Xi.patch \
           file://0003-xilinxfb-Fix-regression-in-call-to-XPS-TFT-controlle.patch \
           file://0004-virtex440-ml507.dts-Update-device-tree-file-using-Xi.patch \
           file://defconfig"

# Support for binary device tree generation
XILINX_BOARD ?= "${@find_board(bb.data.getVar('XILINX_BSP_PATH', d, 1), d)}"
FILESPATH = "${@base_set_filespath([ '${FILE_DIRNAME}/${PN}-${PV}/${SOC_FAMILY}' ], d)}"

COMPATIBLE_MACHINE = "(virtex-4|virtex-5)"
