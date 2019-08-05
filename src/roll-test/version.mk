NAME       = sdsc-pgi-roll-test
VERSION    = 1
RELEASE    = 8
PKGROOT    = /root/rolltests

CUDAVERSION=cuda
ifneq ("$(ROLLOPTS)", "$(subst cuda=,,$(ROLLOPTS))")
  CUDAVERSION = $(subst cuda=,,$(filter cuda=%,$(ROLLOPTS)))
endif

RPM.EXTRAS = AutoReq:No
RPM.FILES  = $(PKGROOT)/pgi.t
