FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

### ZE7000 machine configuration ###
KBRANCH_ze7000-zynq7 = "master"
SRCREV_ze7000-zynq7 = "f9d391370402f7428cd12e7aaa5c8ab768ba5332"

SRC_URI_append_ze7000-zynq7 = " \
            file://zx3-zynq7/0001-zx3-phy-micrel-phy-init.patch \
            file://zx3-zynq7/0002-zx3-phy-adapt-marvell-settings.patch \
            file://zx3-zynq7/0003-zx3-xilinx_emacps-make-phy-address-configurable.patch \
            file://zx3-zynq7/0004-zx3-sdhci-add-sd-card-support.patch \
            file://zx3-zynq7/0005-xilinx_emacps-allow-MTU-of-1500.patch \
            file://zx3-zynq7/0006-xilinx_emacps-Set-the-maximum-frame-reception-size-t.patch \
            file://zx3-zynq7/0007-net-phy-disable-buggy-pause-feature-of-micrel-KSZ903.patch \
            file://defconfig \
            "

KBRANCH_zx3-pm3-zynq7 = "master"
SRCREV_zx3-pm3-zynq7 = "f9d391370402f7428cd12e7aaa5c8ab768ba5332"

SRC_URI_append_zx3-pm3-zynq7 = " \
            file://zx3-zynq7/0001-zx3-phy-micrel-phy-init.patch \
            file://zx3-zynq7/0002-zx3-phy-adapt-marvell-settings.patch \
            file://zx3-zynq7/0003-zx3-xilinx_emacps-make-phy-address-configurable.patch \
            file://zx3-zynq7/0004-zx3-sdhci-add-sd-card-support.patch \
            file://zx3-zynq7/0005-xilinx_emacps-allow-MTU-of-1500.patch \
            file://zx3-zynq7/0006-xilinx_emacps-Set-the-maximum-frame-reception-size-t.patch \
            file://zx3-zynq7/0007-net-phy-disable-buggy-pause-feature-of-micrel-KSZ903.patch \
            file://defconfig \
            "

do_configure_append() {
  # Use a defconfig file if provided instead of appending again and again
  [ -f ${WORKDIR}/defconfig ] && cp ${WORKDIR}/defconfig ${S}/.config
}
