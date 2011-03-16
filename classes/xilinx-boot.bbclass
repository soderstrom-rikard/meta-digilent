# Copyright (C) 2007, Stelios Koroneos - Digital OPSiS, All Rights Reserved
# Copyright (C) 2010, Adrian Alonso <aalonso00@gmail.com>
# Released under the MIT license (see packages/COPYING)
#
#This class handles all the intricasies of getting the required files from the
#ISE/EDK/project to the kernel and prepare u-boot bootloader for compilation.
#The Xilinx EDK supports 2 different architectures : PowerPC (ppc 405,440) and Microblaze
#Only the PowerPC BSP has been tested so far
#For this to work correctly you need to add XILINX_BSP_PATH and XILINX_BOARD to your
#local.conf
#XILINX_BSP_PATH should have the complete path to your project dir
#XILINX_BOARD should have the board type i.e ML403
#
#Currently tested on
#Xilinx ML405
#Xilinx ML507
#More to come soon ;)

def uboot_machine(a, d):
    import re

    board = bb.data.getVar('XILINX_BOARD', d, 1)
    target = bb.data.getVar('TARGET_CPU', d, 1)
    if re.match('powerpc', a):
        if board == 'ml507':
            return 'ml507_config'
        elif board == 'ml405':
            return 'ml405_config'
        else:
            return 'xilinx-ppc' + target + '-generic_config'
    else:
        return target + '-generic_config'

def uboot_target(a, d):
    import re

    board = bb.data.getVar('XILINX_BOARD', d, 1)
    target = bb.data.getVar('TARGET_CPU', d, 1) + '-generic'
    if re.match('powerpc', a):
        if board == 'ml507':
            return 'ml507'
        elif board == 'ml405':
            return 'ml405'
        else:
            return 'ppc' + target
    else:
        return target


do_export_xparam() {
oenote "Replacing xparameters header to match hardware model"
if [ "${TARGET_ARCH}" == "powerpc" ]; then
	xparam="${XILINX_BSP_PATH}/ppc${TARGET_CPU}_0/include/xparameters.h"
	cpu="PPC`echo ${TARGET_CPU} | tr '[:lower:]' '[:upper:]'`"
else
	xparam="${XILINX_BSP_PATH}/${TARGET_CPU}_0/include/xparameters.h"
	cpu=`echo ${TARGET_CPU} | tr '[:lower:]' '[:upper:]'`
fi
if [ -e "$xparam" ]; then
	cp ${xparam} ${S}/board/xilinx/${UBOOT_TARGET}
	echo "/*** Cannonical definitions ***/
#define XPAR_PLB_CLOCK_FREQ_HZ XPAR_PROC_BUS_0_FREQ_HZ
#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_${cpu}_CORE_CLOCK_FREQ_HZ
#ifndef XPAR_DDR2_SDRAM_MEM_BASEADDR
# define XPAR_DDR2_SDRAM_MEM_BASEADDR XPAR_DDR_SDRAM_MPMC_BASEADDR
#endif
#define XPAR_PCI_0_CLOCK_FREQ_HZ    0" >> ${S}/board/xilinx/${UBOOT_TARGET}/xparameters.h
else
    oefatal "No xparameters header file found, missing hardware ref design?"
    exit 1
fi
}

do_mk_xparam() {
oenote "Replacing xparameters.mk configuration file"
if [ "${TARGET_ARCH}" == "powerpc" ]; then
	xparam="${XILINX_BSP_PATH}/ppc${TARGET_CPU}_0/include/xparameters.h"

    if grep -qoe XPAR_IIC_0_DEVICE_ID ${xparam}; then
        echo -e "XPAR_IIC        := y" > ${S}/board/xilinx/${UBOOT_TARGET}/xparameters.mk
    else
        echo -e "XPAR_IIC        := n" > ${S}/board/xilinx/${UBOOT_TARGET}/xparameters.mk
    fi

    if grep -qoe XPAR_LLTEMAC_0_DEVICE_ID ${xparam}; then
        echo -e "XPAR_LLTEMAC    := y" >> ${S}/board/xilinx/${UBOOT_TARGET}/xparameters.mk
    else
        echo -e "XPAR_LLTEMAC    := n" >> ${S}/board/xilinx/${UBOOT_TARGET}/xparameters.mk
    fi

    if grep -qoe XPAR_SYSACE_0_DEVICE_ID ${xparam}; then
        echo -e "XPAR_SYSACE     := y" >> ${S}/board/xilinx/${UBOOT_TARGET}/xparameters.mk
    else
        echo -e "XPAR_SYSACE     := n" >> ${S}/board/xilinx/${UBOOT_TARGET}/xparameters.mk
    fi
fi
}

do_mk_sysace() {
oenote "Generate system ace image"
# Set Xilinx EDK tools
if [ -z ${XILINX_EDK} ]; then
	# Get Xilinx version
	if [ ${BUILD_ARCH} == "x86_64" ]; then
		EDK_SRCIPT="settings64.sh"
	else
		EDK_SRCIPT="settings.sh"
	fi
	# Strip EDK version
	XILINX_VER=`echo ${XILINX_LOC} | tr -d '[:alpha:]/_'`
	if [ "${XILINX_VER}" \> "13" ]; then
		source ${XILINX_LOC}/${EDK_SRCIPT} ${XILINX_LOC}
	else
		# EDK version prior to 13.1 require to additionaly source this scripts
		source ${XILINX_LOC}/${EDK_SRCIPT} ${XILINX_LOC}
		source ${XILINX_LOC}/ISE/${EDK_SRCIPT} ${XILINX_LOC}/ISE
		source ${XILINX_LOC}/EDK/${EDK_SRCIPT} ${XILINX_LOC}/EDK
	fi
fi

# The system ace image generation assumes that user had
# configure the project to use pcc440_0_bootloop software
# project to initialize bram
#
# Note:
# This could be ovirrided by setting in ${XILINX_BSP_PATH}/system_incl.make
# BRAMINIT_ELF_FILES = $(PPC440_0_BOOTLOOP)
# BRAMINIT_ELF_FILES_ARGS = -pe ppc440_0 $(PPC440_0_BOOTLOOP)
# For Xilinx EDK 13.1 Bootlop is set by default
#
cd ${XILINX_BSP_PATH}
if [ ! -f implementation/download.bit ]; then
	# Bitstream not found generate it
	make -f ${XILINX_BSP_PATH}/system.make init_bram
fi
xmd -tcl genace.tcl -hw implementation/download.bit -elf u-boot \
-ace u-boot-${XILINX_BOARD}.ace -board ${XILINX_BOARD}
}

do_configure_prepend() {
#first check that the XILINX_BSP_PATH and XILINX_BOARD have been defined in local.conf
#now depending on the board type and arch do what is nessesary
if [ -n "${XILINX_BSP_PATH}" ]; then
	if [ -n "${XILINX_BOARD}" ]; then
        if [ -d "${S}/board/xilinx" ]; then
            do_export_xparam
            do_mk_xparam
        fi
	else
		oefatal "XILINX_BOARD not defined ! Exit"
		exit 1
	fi
else
	oefatal "XILINX_BSP_PATH not defined ! Exit"
	exit 1
fi
}

do_deploy_prepend() {
# Install u-boot elf image
if [ -d "${XILINX_BSP_PATH}" ]; then
	if [ -e "${S}/u-boot" ]; then
		install ${S}/u-boot ${XILINX_BSP_PATH}
		do_mk_sysace
		install ${XILINX_BSP_PATH}/u-boot-${XILINX_BOARD}.ace ${DEPLOYDIR}
	fi
fi
}
