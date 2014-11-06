NAME           = sdsc-pgi
VERSION        = 13.2
RELEASE        = 2
PKGROOT        = /opt/pgi

SRC_SUBDIR     = pgi

SOURCE_NAME    = pgi
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
