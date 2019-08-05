REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

build:

install:: typical-roll-test-install
	 perl -pi -e "s!CUDAVERSION!$(CUDAVERSION)!" $(ROOT)/$(PKGROOT)/pgi.t

clean::
