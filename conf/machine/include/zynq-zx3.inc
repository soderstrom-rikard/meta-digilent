#@TYPE: Machine
#@NAME: zynq-zy3
#@DESCRIPTION: Machine configuration for the zx3 module
#@HOMEPAGE = "http://www.netmodule.com"

require conf/machine/include/tune-zynq.inc
require conf/machine/include/machine-xilinx-default.inc

MACHINE_FEATURES := ""
#IMAGE_FSTYPES and IMAGE_ROOTFS_SIZE are set in recipes-core/images/
#
#when we set limits, we really mean it
IMAGE_OVERHEAD_FACTOR := "1"
#QSPI flash has 64kB erase size
EXTRA_IMAGECMD_jffs2 = "-lnp -e64KiB"

SERIAL_CONSOLE = "115200 ttyPS0"

# microZed machine definition known by Xilinx UBOOT
UBOOT_MACHINE = "zx3_ze7000"

# force the kernel creation process to create a new uImage with the correct addresses
KEEPUIMAGE = "no"

#generate ramdisk, rootfs and ubi
IMAGE_ROOTFS_SIZE = "32768"
IMAGE_FSTYPES := "ext2.gz tar.bz2 ubi ubifs"

#1023 erase blocks with a size of 126KiB =  something around 125.877 MB
MKUBIFS_ARGS = "-m 2048 -e 126976 -c 4096"
UBINIZE_ARGS = "-m 2048 -p 128KiB"

UBI_VOLNAME = "ubi-rootfs"

UBOOT_LOADADDRESS = "0x00008000"
UBOOT_ENTRYPOINT = "${UBOOT_LOADADDRESS}"
# force the kernel creation process to create a new uImage with the correct addresses
KEEPUIMAGE = "no"
