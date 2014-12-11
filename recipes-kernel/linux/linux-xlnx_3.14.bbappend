FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

### ZE7000 machine configuration ###
KBRANCH_ze7000-zynq7 = "zx3-v3.14"
SRCREV_ze7000-zynq7 = "${AUTOREV}"
SRC_URI_ze7000-zynq7 = "git://github.com/netmodule/kernel-zx3.git;protocol=https;branch=${KBRANCH}"

SRC_URI_append_ze7000-zynq7 = " \
            file://defconfig \
            "

### PM3 machine configuration ###
KBRANCH_zx3-pm3-zynq7 = "zx3-v3.14"
SRCREV_zx3-pm3-zynq7 = "4ea440987eb3b5a9cb1f3fd50bb63c86703ef438"
SRC_URI_zx3-pm3-zynq7 = "git://github.com/netmodule/kernel-zx3.git;protocol=https;branch=${KBRANCH}"

SRC_URI_append_zx3-pm3-zynq7 = " \
            file://defconfig \
            "

do_configure_append() {
  # Use a defconfig file if provided instead of appending again and again
  [ -f ${WORKDIR}/defconfig ] && cp ${WORKDIR}/defconfig ${S}/.config
}
