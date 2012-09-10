DEFAULTTUNE ?= "ppc405e"

require conf/machine/include/powerpc/arch-powerpc.inc

TUNEVALID[ppc405e] = "Enable ppc405e specific processor optimizations"
TUNE_CCARGS += "${@bb.utils.contains("TUNE_FEATURES", "ppc405e", "-mcpu=405fp", "", d)}"

AVAILTUNES += "ppc405e"
TUNE_FEATURES_tune-ppc405e = "m32 ppc405e fpu-hard"
TUNE_PKGARCH_tune-ppc405e = "ppc405e"
PACKAGE_EXTRA_ARCHS_tune-ppc405e = "${PACKAGE_EXTRA_ARCHS_tune-powerpc} ppc405e"

# glibc configure options to get ppc405e specific library (for sqrt)
GLIBC_EXTRA_OECONF += "${@bb.utils.contains("TUNE_FEATURES", "ppc405e", "-with-cpu=405fp", "", d)}"
