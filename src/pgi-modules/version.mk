NAME        = pgi-modules
RELEASE     = 2
PKGROOT     = /opt/modulefiles/compilers/pgi

VERSION_SRC = $(REDHAT.ROOT)/src/pgi/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
