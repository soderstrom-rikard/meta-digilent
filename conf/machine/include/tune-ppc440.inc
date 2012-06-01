DEFAULTTUNE ?= "ppc440"

require conf/machine/include/powerpc/arch-powerpc.inc

TUNEVALID[ppc440] = "Enable ppc440 specific processor optimizations"
TUNE_CCARGS += "${@bb.utils.contains("TUNE_FEATURES", "ppc440", "-mcpu=440", "", d)}"

AVAILTUNES += "ppc440"
TUNE_FEATURES_tune-ppc440 = "m32 fpu-soft ppc440"
TUNE_PKGARCH_tune-ppc440 = "ppc440"
PACKAGE_EXTRA_ARCHS_tune-ppc440 = "${PACKAGE_EXTRA_ARCHS_tune-powerpc-nf} ppc440"

# glibc configure options to get ppc440 specific library (for sqrt)
GLIBC_EXTRA_OECONF += "${@bb.utils.contains("TUNE_FEATURES", "ppc440", "-with-cpu=440", "", d)}"
