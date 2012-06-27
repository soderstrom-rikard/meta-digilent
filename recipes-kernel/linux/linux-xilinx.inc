DESCRIPTION = "Linux kernel for Xilinx platforms"
SECTION = "kernel"
LICENSE = "GPLv2"

LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

PROVIDES += "virtual/kernel"

KBRANCH ?= "master"

# Pick up shared functions
require recipes-kernel/linux/linux-dtb.inc

S = "${WORKDIR}/git"

# extra tasks
