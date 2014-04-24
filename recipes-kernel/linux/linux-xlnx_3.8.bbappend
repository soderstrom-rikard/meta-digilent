FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

ZYNQ_ZX3_PATCHSET = " \
			file://zynq-zx3/0001-ze7000-phy-micrel-phy-init.patch                              \
			file://zynq-zx3/0002-ze7000-phy-adapt-marvell-settings.patch                       \
			file://zynq-zx3/0003-zynq-nand-do-not-wait-on-erase-completion-in-cmd-fct.patch    \
			file://zynq-zx3/0004-clk-remove-clock-notifier-at-unregister.patch                 \
			file://zynq-zx3/0005-xdevcfg-Make-sure-that-devcfg-is-not-in-loopback-mod.patch    \
			file://zynq-zx3/0006-xilinx_emacps-Make-phy-address-configurable.patch             \
			file://zynq-zx3/0007-kernel-sdhci-add-sd-card-support.patch                        \
			file://zynq-zx3/0008-xilinx_emacps-Changed-change_mtu-so-that-it-is-possi.patch    \
			file://zynq-zx3/0009-xilinx_emacps-Set-the-maximum-frame-reception-size-t.patch    \
			"

PATCH_LIST_zynq-ze7000 = "${ZYNQ_ZX3_PATCHSET}"
# Make sure that this config is appended at the end of MACHINE_KCONFIG (because of zynq_defconfig_3.8.cfg)
MACHINE_KCONFIG_append_zynq-ze7000 = " zynq-ze7000/ze7000_configuration.cfg "

SRC_URI_append += " ${PATCH_LIST}"

# Make sure that the same order as in MACHINE_KCONFIG is used (overwrite default find_config_fragments)
def find_config_fragments(d):
    machineKConfig=d.getVar('MACHINE_KCONFIG', True)
    workDir=d.getVar('WORKDIR', True) + "/"
    sources_list=[]
    for s in machineKConfig.split():
        bb.note("s: " + s)
        if s.endswith('.cfg'):
            s=workDir+s
            bb.note("Source: " + s)
            sources_list.append(s)
    return sources_list
