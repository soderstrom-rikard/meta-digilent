DESCRIPTION = "Xilinx linux kernel support for Zynq-7 Base TRD 14.5"

MACHINE_DEVICETREE_zc702-zynq7 := " \
        zc702/zc702-zynq7-board.dtsi \
        zc702/zc702-zynq7.dts \
        common/zynq7-base-trd.dtsi \
        zc702/zc702-zynq7-base-trd.dts \
        "
MACHINE_KCONFIG_zc702-zynq7    := "common/linux/zynq/xilinx_zynq_base_trd_defconfig_${LINUX_VERSION}.cfg"

MACHINE_DEVICETREE_zc706-zynq7 := " \
        zc706/zc706-zynq7-board.dtsi \
        zc706/zc706-zynq7.dts \
        zc706/zc706-zynq7-pcie-trd-qspi.dts \
        "
MACHINE_KCONFIG_zc706-zynq7    := "common/linux/zynq/xilinx_zynq_base_trd_defconfig_${LINUX_VERSION}.cfg"
