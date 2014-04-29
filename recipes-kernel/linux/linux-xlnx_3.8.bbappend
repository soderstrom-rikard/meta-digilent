FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

ZX3_ZYNQ7_PATCHSET = " \
			file://zx3-zynq7/0001-ze7000-phy-micrel-phy-init.patch                              \
			file://zx3-zynq7/0002-ze7000-phy-adapt-marvell-settings.patch                       \
			file://zx3-zynq7/0003-zynq-nand-do-not-wait-on-erase-completion-in-cmd-fct.patch    \
			file://zx3-zynq7/0004-clk-remove-clock-notifier-at-unregister.patch                 \
			file://zx3-zynq7/0005-xdevcfg-Make-sure-that-devcfg-is-not-in-loopback-mod.patch    \
			file://zx3-zynq7/0006-xilinx_emacps-Make-phy-address-configurable.patch             \
			file://zx3-zynq7/0007-kernel-sdhci-add-sd-card-support.patch                        \
			file://zx3-zynq7/0008-xilinx_emacps-Changed-change_mtu-so-that-it-is-possi.patch    \
			file://zx3-zynq7/0009-xilinx_emacps-Set-the-maximum-frame-reception-size-t.patch    \
			"

PATCH_LIST ?= ""

PATCH_LIST_ze7000-zynq7 = "${ZX3_ZYNQ7_PATCHSET}"

# Make sure that this config is appended at the end of MACHINE_KCONFIG (because of zynq_defconfig_3.8.cfg)
MACHINE_KCONFIG_append_ze7000-zynq7 = " ze7000-zynq7/ze7000_configuration.cfg "

SRC_URI_append += " ${PATCH_LIST}"

# Make sure that the same order as in MACHINE_KCONFIG is used (overwrite default find_config_fragments)
def find_config_fragments(d):
    machineKConfig=d.getVar('MACHINE_KCONFIG', True)
    workDir=d.getVar('WORKDIR', True) + "/"
    sources_list=[]
    for s in machineKConfig.split():
        if s.endswith('.cfg'):
            s=workDir+s
            sources_list.append(s)
    return sources_list
