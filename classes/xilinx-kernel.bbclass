# Copyright (C) 2007, Stelios Koroneos - Digital OPSiS, All Rights Reserved
# Copyright (C) 2010, Adrian Alonso <aalonso00@gmail.com>
# Released under the MIT license (see packages/COPYING)
#
#This class handles all the intricasies of getting the required files from the
#ISE/EDK/project to the kernel and prepare the kernel for compilation.
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

def map_target(a, d):
	import re
	board = bb.data.getVar('XILINX_BOARD', d, 1)
	cpu = bb.data.getVar('TARGET_CPU', d, 1)

	if re.match('powerpc', a):
		return cpu + '-' + board
	else:
		return 'system'


do_configure_prepend() {
#first check that the XILINX_BSP_PATH and XILINX_BOARD have been defined in local.conf
#now depending on the board type and arch do what is nessesary
if [ -n "${XILINX_BSP_PATH}" ]; then
	if [ -n "${XILINX_BOARD}" ]; then
		if [ -d "${S}/arch/${TARGET_ARCH}/boot" ]; then
			dts=`find "${XILINX_BSP_PATH}" -name *.dts -print`
			if [ -e "$dts" ]; then
				oenote "Replacing device tree to match hardware model"
				if [ "${TARGET_ARCH}" == "powerpc" ]; then
					cp -pP ${dts} ${S}/arch/powerpc/boot/dts/virtex${TARGET_BOARD}.dts
				else
					cp -pP ${dts} ${S}/arch/microblaze/platform/generic/${TARGET_BOARD}.dts
				fi
			else
				oefatal "No device tree found, missing hardware ref design?"
				exit 1
			fi
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
