# Provides the Xilinx Virtex-5 common settings

# Specify the SOC Family
SOC_FAMILY = "virtex-5"

include conf/machine/include/virtex-5-default-providers.inc

# Add u-boot image to rootfs
EXTRA_IMAGEDEPENDS = "u-boot-xilinx"

# Specify kernel image type
KERNEL_IMAGETYPE = "uImage"

# Ship kernel modules
MACHINE_EXTRA_RRECOMMENDS = "kernel-modules"

# Specify rootfs image filesystem types
IMAGE_FSTYPES += "tar.gz"
