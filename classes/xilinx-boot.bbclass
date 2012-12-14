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
#Xilinx ML403 configured as ML405 same processor core only changes FPGA density
#Xilinx ML510 configured as ML507
#More to come soon ;)

do_export_xparam() {
bbnote "Replacing xparameters header to match hardware model"
xparam=$1
cp ${xparam} ${S}/board/xilinx/${XILINX_BOARD}
echo "/*** Cannonical definitions ***/
#ifndef XPAR_DDR2_SDRAM_MEM_BASEADDR
# define XPAR_DDR2_SDRAM_MEM_BASEADDR XPAR_DDR_SDRAM_MPMC_BASEADDR
#endif
" >> ${S}/board/xilinx/${XILINX_BOARD}/xparameters.h
}

do_mk_xparam() {
bbnote "Replacing xparameters.mk configuration file"
xparam=$1
if [ "${TARGET_ARCH}" = "powerpc" ]; then
    if grep -qoe XPAR_IIC_0_DEVICE_ID ${xparam}; then
        echo -e "XPAR_IIC        := y" > ${S}/board/xilinx/${XILINX_BOARD}/xparameters.mk
    else
        echo -e "XPAR_IIC        := n" > ${S}/board/xilinx/${XILINX_BOARD}/xparameters.mk
    fi

    if grep -qoe XPAR_LLTEMAC_0_DEVICE_ID ${xparam}; then
        echo -e "XPAR_LLTEMAC    := y" >> ${S}/board/xilinx/${XILINX_BOARD}/xparameters.mk
    else
        echo -e "XPAR_LLTEMAC    := n" >> ${S}/board/xilinx/${XILINX_BOARD}/xparameters.mk
    fi

    if grep -qoe XPAR_SYSACE_0_DEVICE_ID ${xparam}; then
        echo -e "XPAR_SYSACE     := y" >> ${S}/board/xilinx/${XILINX_BOARD}/xparameters.mk
    else
        echo -e "XPAR_SYSACE     := n" >> ${S}/board/xilinx/${XILINX_BOARD}/xparameters.mk
    fi
fi
}

do_mk_sysace() {
bbnote "Generate system ace image"
# Set Xilinx EDK tools
if [ -z ${XILINX_EDK} ]; then
	# Get Xilinx version
	XILINX_VER=`echo ${XILINX_LOC} | tr -d '[:alpha:]/_'`
	bbnote "XILINX ISE version ${XILINX_VER}"
	if [ "${XILINX_VER}" \> "13" ]; then
		# EDK version 13.1 and higher
		# Check host computer build architecture
		if [ "${BUILD_ARCH}" = "x86_64" ]; then
			EDK_SCRIPT="settings64.sh"
		else
			EDK_SCRIPT="settings32.sh"
		fi
		# Setup Xilinx environment variables
		source ${XILINX_LOC}/${EDK_SCRIPT} ${XILINX_LOC}
	else
		# EDK versions prior to 13.1
		# Check host computer build architecture
		if [ "${BUILD_ARCH}" = "x86_64" ]; then
			EDK_SCRIPT="settings64.sh"
		else
			EDK_SCRIPT="settings.sh"
		fi
		# Setup Xilinx environment variables
		# EDK versions prior to 13.1 require additional ISE and EDK scripts to be sourced
		source ${XILINX_LOC}/${EDK_SCRIPT} ${XILINX_LOC}
		source ${XILINX_LOC}/ISE/${EDK_SCRIPT} ${XILINX_LOC}/ISE
		source ${XILINX_LOC}/EDK/${EDK_SCRIPT} ${XILINX_LOC}/EDK
	fi
	bbnote "XILINX EDK script location ${XILINX_LOC}/${EDK_SCRIPT}"
fi

# The system ace image generation assumes that user had
# configure the project to use pcc440_0_bootloop software
# project to initialize bram
#
# Note:
# This could be ovirrided by setting in ${XILINX_BSP_PATH}/system_incl.make
# BRAMINIT_ELF_FILES = $(PPC440_0_BOOTLOOP)
# BRAMINIT_ELF_FILES_ARGS = -pe ppc440_0 $(PPC440_0_BOOTLOOP)
# For Xilinx EDK 13.1 Bootloop is set by default
#
cd ${XILINX_BSP_PATH}
XILINX_BITSTREAM_FILE_NAME=system.bit

# Locate the bitstream file.
XILINX_BITSTREAM_FILE=$(find ${XILINX_BSP_PATH} -path "*/${XILINX_BITSTREAM_FILE_NAME}" -print)
if [ -z ${XILINX_BITSTREAM_FILE} ]; then
		# Bitstream not found, generate it.
		bbnote "Bitstream not found, generating it."

		# Locate the bitstream makefile.
		XILINX_BITSTREAM_MAKEFILE_NAME=system.make
		XILINX_BITSTREAM_MAKEFILE=$(find ${XILINX_BSP_PATH} -name "${XILINX_BITSTREAM_MAKEFILE_NAME}" -print)
		bbnote "Using bitstream makefile ${XILINX_BITSTREAM_MAKEFILE}"

		# Change to the bitstream makefile directory.
		XILINX_BITSTREAM_MAKEFILE_DIRECTORY=$(dirname ${XILINX_BITSTREAM_MAKEFILE})
		cd ${XILINX_BITSTREAM_MAKEFILE_DIRECTORY}

		# Generate the bitstream.
		make -f ${XILINX_BITSTREAM_MAKEFILE} init_bram

		# Store the location of the newly generated bitstream file.
		XILINX_BITSTREAM_FILE=$(find ${XILINX_BSP_PATH} -path "*/${XILINX_BITSTREAM_FILE_NAME}" -print)
		bbnote "Generated bitstream file ${XILINX_BITSTREAM_FILE}"
	else
		# Bitstream found, use existing bitstream.
		bbnote "Using existing bitstream file ${XILINX_BITSTREAM_FILE}"
fi

if [ "${TARGET_ARCH}" = "powerpc" ]; then
	# Find u-boot start address
	start_address=`${TARGET_PREFIX}objdump -x u-boot | grep -w "start address" | cut -d ' ' -f3`
	# Generate ACE image
	xmd -tcl genace.tcl -hw ${XILINX_BITSTREAM_FILE} -elf u-boot \
	-target ppc_hw -start_address ${start_address} -ace u-boot-${XILINX_BOARD}.ace \
	-board ${XILINX_BOARD}
fi
}

do_configure_prepend() {
# First check that the XILINX_BSP_PATH and XILINX_BOARD have been defined in local.conf
# and then perform required configuration, depending upon the board type and architecture.
if [ -n "${XILINX_BSP_PATH}" ]; then
	if [ "${XILINX_BOARD}" != "unknown" ]; then
        if [ -d "${S}/board/xilinx" ]; then
            # Search for xparameter header
            headers=`find ${XILINX_BSP_PATH} -path "*/include/xparameters.h" -print`
            # trim if multiple version are found
            xparam=`echo ${headers} | cut -d ' ' -f1`
			if [ -n "${xparam}" ]; then
				do_export_xparam ${xparam}
				do_mk_xparam ${xparam}
			else
				bbfatal "No xparameters header file found, missing Xilinx SDK project"
				exit 1
			fi
        fi
	else
        bbnote "Xilinx board model: ${XILINX_BOARD}"
		bbfatal "XILINX_BSP_PATH points to a valid Xilinx XPS project directory? ! Exit"
		exit 1
	fi
else
	bbfatal "XILINX_BSP_PATH not defined ! Exit"
	exit 1
fi
}

do_deploy_prepend() {
# Install u-boot elf image
if [ -d "${XILINX_BSP_PATH}" ]; then
	if [ -e "${S}/u-boot" ]; then
        bbnote "Deploying uboot elf image to ${XILINX_BSP_PATH}"
		install ${S}/u-boot ${XILINX_BSP_PATH}
    fi
    if [ -n "${XILINX_LOC}" ]; then
                bbnote "Xilinx design tools installed in ${XILINX_LOC}"
		do_mk_sysace
        if [ -e  "${XILINX_BSP_PATH}/u-boot-${XILINX_BOARD}.ace" ]; then
		    install ${XILINX_BSP_PATH}/u-boot-${XILINX_BOARD}.ace ${DEPLOYDIR}
        fi
    else
        bbnote "XILINX_LOC undefined can't generate system ace image"
    fi
fi
}
