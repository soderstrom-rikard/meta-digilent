
addtask pre_install_tool_changes before do_install after do_configure
do_pre_install_tool_changes() {
	# Create Directories that might exist, so that they can be deleted and keep
	# the do_install step happy.

	sysroot="${EXTERNAL_TOOLCHAIN_SYSROOT}"

	# Wants to delete '${D}${datadir}/zoneinfo'
	mkdir -p ${sysroot}/usr/share/zoneinfo
}

# Ignore GNU_HASH for libbfd (microblaze toolchain only)
INSANE_SKIP_${PN}-dev += "ldflags"
