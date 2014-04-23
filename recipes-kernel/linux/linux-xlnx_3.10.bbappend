DESCRIPTION = "Xilinx linux kernel support for Zynq-7 Base TRD 14.5"

MACHINE_DEVICETREE_zc702-zynq7 := " \
        zc702/zc702-zynq7-board.dtsi \
        zc702/zc702-zynq7-base-trd.dts \
        common/zynq-7-base-trd.dtsi \
        "
MACHINE_KCONFIG_zc702-zynq7    := "common/linux/zynq/xilinx_zynq_base_trd_defconfig_${LINUX_VERSION}.cfg"
