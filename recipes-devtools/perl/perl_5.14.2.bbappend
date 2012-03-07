THISDIR := "${@os.path.dirname(bb.data.getVar('FILE', d, True))}"
FILESPATH =. "${@base_set_filespath(["${THISDIR}/${PN}"], d)}:"
# Config options for microblaze
SRC_URI_microblaze += " file://config.sh"
