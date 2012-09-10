DEFAULTTUNE ?= "ppc440e"

require conf/machine/include/powerpc/arch-powerpc.inc

TUNEVALID[ppc440e] = "Enable ppc440e specific processor optimizations"
TUNE_CCARGS += "${@bb.utils.contains("TUNE_FEATURES", "ppc440e", "-mcpu=440fp", "", d)}"

AVAILTUNES += "ppc440e"
TUNE_FEATURES_tune-ppc440e = "m32 ppc440e fpu-hard"
TUNE_PKGARCH_tune-ppc440e = "ppc440e"
PACKAGE_EXTRA_ARCHS_tune-ppc440e = "${PACKAGE_EXTRA_ARCHS_tune-powerpc} ppc440e"

# glibc configure options to get ppc440e specific library (for sqrt)
GLIBC_EXTRA_OECONF += "${@bb.utils.contains("TUNE_FEATURES", "ppc440e", "-with-cpu=440fp", "", d)}"
