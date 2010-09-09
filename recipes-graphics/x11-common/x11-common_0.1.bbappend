THISDIR := "${@os.path.dirname(bb.data.getVar('FILE', d, True))}"
FILESPATH =. "${@base_set_filespath(["${THISDIR}/files"], d)}:"

SRC_URI_append += "file://Xserver-module_id-for-virtex-platforms.patch \
                   file://Xserver-virtex-platform-support.patch"
