NAME           = sdsc-pgi
VERSION        = 15.7
RELEASE        = 1
PKGROOT        = /opt/pgi

SRC_SUBDIR     = pgi

SOURCE_NAME    = pgilinux
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = 2015-$(VERSION)-x86_64
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
