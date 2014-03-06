NAME            = pgi
VERSION         = 13.2
RELEASE         = 1
RPM.EXTRAS         = AutoReq:No

SRC_SUBDIR      = pgi

PGI_NAME        = pgi
PGI_VERSION     = $(VERSION)
PGI_PKG_SUFFIX  = tar.gz
PGI_SOURCE_PKG  = $(PGI_NAME)-$(PGI_VERSION).$(PGI_PKG_SUFFIX)
PGI_SOURCE_DIR  = $(PGI_SOURCE_PKG:%.$(PGI_PKG_SUFFIX)=%)

TAR_GZ_PKGS     = $(PGI_SOURCE_PKG)
