THISDIR := "${@os.path.dirname(bb.data.getVar('FILE', d, True))}"
FILESPATH =. "${@base_set_filespath(["${THISDIR}/files"], d)}:"

SRC_URI_append += "file://openssl-linux-gnueabi-powerpc-configuration.patch"
