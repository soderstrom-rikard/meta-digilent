DEFAULTTUNE ?= "microblaze"

TUNEVALID[microblaze] = "Enable microblaze specific processor optimizations"
TUNE_CCARGS += "${@bb.utils.contains("TUNE_FEATURES", "microblaze", "-mcpu=v8.10a", "", d)}"
TUNE_PKGARCH = "${@bb.utils.contains("TUNE_FEATURES", "microblaze", "microblaze", "${PPCPKGARCH}", d)}"

TARGET_FPU = "soft"
AVAILTUNES += "microblaze"
TUNE_FEATURES_tune-microblaze = "m32 microblaze"
PACKAGE_EXTRA_ARCHS_tune-microblaze = "microblaze"

#MACHINEOVERRIDES .= "microblaze"
