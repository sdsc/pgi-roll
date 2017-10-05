NAME           = sdsc-pgi
VERSION        = 17.5
RELEASE        = 2
PKGROOT        = /opt/pgi

SRC_SUBDIR     = pgi

SOURCE_NAME    = pgilinux
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = 2017-175-x86_64
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = install_components

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
RPM.PREFIX     = $(PKGROOT)
