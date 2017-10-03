# $Id$
#
# @Copyright@
#
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 7.0 (Manzinita)
#
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided
# with the distribution.
#
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement:
#
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
#
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of
# the associated name, interested parties should contact Technology
# Transfer & Intellectual Property Services, University of California,
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910,
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# @Copyright@
#
# $Log$

REDHAT.ROOT = $(CURDIR)/../../
RPM.EXTRAS = %define __os_install_post /usr/lib/rpm/brp-compress

RPMS = 3
RPM_TO_BUILD = 1

-include $(ROCKSROOT)/etc/Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

PGI_CACHE = $(REDHAT.ROOT)/cache/build-pgi

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	( \
	  $(DESCRIBE_PKG) \
	) > $@

LICENSE: $(SRC_DIRS)
	$(CHECK_LICENSE_FILES)
	echo STMicroelectronics > $@

$(SOURCE_DIR): $(SOURCE_PKG)
	mkdir $@
	cd $@ && tar zxvf ../$(SOURCE_PKG)

build: $(SRC_DIRS)
	rm -f install
	mkdir -p $(PGI_CACHE)
	( \
          if test $(RPM_TO_BUILD) == "1"; then \
	    cd $(SOURCE_DIR); \
	    PGI_SILENT=true PGI_ACCEPT_EULA=accept PGI_INSTALL_NVIDIA=true PGI_INSTALL_DIR=$(PKGROOT) \
	    ./install $(VERSION); \
            cp -r $(PKGROOT) $(PGI_CACHE); \
          fi \
	)
	rm -rf $(PKGROOT)
	@echo "::: Package $(NAME) build complete :::"

install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	( \
          cd $(PGI_CACHE)/pgi; \
          find . \( -type f -o -type l \) | sort | perl -e 'for(my $$i=0;<>;$$i++){chomp and `/bin/cp --parents -d "$$_" $(ROOT)/$(PKGROOT)/` if $$i%$(RPMS)+1 == $(RPM_TO_BUILD);}'; \
        )
	if test "$(RPM_TO_BUILD)" = "1"; then \
          for rpm in `seq 2 $(RPMS)`; do \
            echo $(MAKE) NAME=$(NAME)_$$rpm RPM_TO_BUILD=$$rpm rpm; \
            $(MAKE) NAME=$(NAME)_$$rpm RPM_TO_BUILD=$$rpm rpm; \
          done; \
          $(INSTALL_LICENSE_FILES); \
        fi
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR) install *.html DESCRIPTION LICENSE
