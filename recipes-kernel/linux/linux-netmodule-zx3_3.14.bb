
LINUX_VERSION = "3.14"
KBRANCH ?= "zx3-v3.14"
SRCREV ?= "4ea440987eb3b5a9cb1f3fd50bb63c86703ef438"

SRC_URI = "git://github.com/netmodule/kernel-zx3.git;protocol=https;branch=${KBRANCH}"

include recipes-kernel/linux/linux-xlnx.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-xlnx/${LINUX_VERSION}:"

### ZE7000 machine configuration ###
SRC_URI_append_ze7000-zynq7 += "file://defconfig"

### PM3 machine configuration ###
SRC_URI_append_zx3-pm3-zynq7 += "file://defconfig"

COMPATIBLE_MACHINE = "ze7000-zynq7|zx3-pm3-zynq7"
