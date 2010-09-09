THISDIR := "${@os.path.dirname(bb.data.getVar('FILE', d, True))}"
FILESPATH =. "${@base_set_filespath(["${THISDIR}/files"], d)}:"

SRC_URI += "file://functions-module_id-for-virtex-platforms.patch"
