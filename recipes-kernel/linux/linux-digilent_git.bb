# This recipe allows for a 'bleeding edge' linux-xlnx repository.
# Since this tree is frequently updated, AUTOREV is used to track its contents.
#
# To enable this recipe, set
# PREFERRED_VERSION_linux-xlnx ?= "${KBRANCH}"
# Alternatively to track and build master branch instead, set
# KBRANCH ?= "master"
# PREFERRED_VERSION_linux-xlnx ?= "${KBRANCH}"

KBRANCH ?= "master-next"
KBRANCH_DEFAULT = "${KBRANCH}"

include recipes-kernel/linux/linux-xlnx.inc

SRC_URI = "git://github.com/soderstrom-rikard/digilent-linux.git;protocol=https;branch=${KBRANCH}"

# Set default SRCREVs. SRCREVs statically set to prevent network access during 
# parsing.  
# AUTOREV is set in the anonymous python routine and resolved when the variables 
# are finalized.
SRCREV = "906a2c987713f723ca826b1e5e2d911d7200e8bb"

python () {
    d.setVar("SRCREV", "${AUTOREV}")
}

LINUX_VERSION ?= "3.14+"
LINUX_VERSION_EXTENSION = "-xilinx-dev"
PV = "${LINUX_VERSION}${LINUX_VERSION_EXTENSION}+git${SRCPV}"
