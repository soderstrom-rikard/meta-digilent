require recipes-bsp/uboot/u-boot.inc
PR = "r6"
THISDIR := "${@os.path.dirname(bb.data.getVar('FILE', d, True))}"
FILESPATH =. "${@base_set_filespath(["${THISDIR}/files"], d)}:"

EXTRA_OEMAKE = "CROSS_COMPILE=${TARGET_PREFIX} OPTFLAGS='-O2'"
BRANCH="master"
TAG="e094f2479ea339d7f48b6826f06f0be4984d9a98"
SRC_URI = "git://git.xilinx.com/u-boot-xlnx.git;branch=${BRANCH};protocol=git \
           file://uboot-remove-inline-qualifier-from-show_boot_progres.patch \
           file://ml405-add-uartlite-config-options.patch \
           file://ml405-replace-hardcode-macros-for-uartns550.patch \
           file://ml507-add-uartlite-config-options.patch \
           file://ml507-replace-hardcode-macros-for-uartns550.patch \
          "
SRCREV = "${TAG}"

inherit xilinx-boot

TARGET_BOARD = "${@map_target(bb.data.getVar('TARGET_ARCH', d, 1), d)}"
UBOOT_TARGET = "${@uboot_target(bb.data.getVar('TARGET_ARCH', d, 1), d)}"
export UBOOT_MACHINE = "${@uboot_machine(bb.data.getVar('TARGET_ARCH', d, 1), d)}"

S = "${WORKDIR}/git"
