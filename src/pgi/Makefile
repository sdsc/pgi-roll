#
# $Id$
#
# @Copyright@
#
# 				Rocks(tm)
# 		         www.rocksclusters.org
# 		        version 4.3 (Mars Hill)
#
# Copyright (c) 2000 - 2007 The Regents of the University of California.
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
# 	"This product includes software developed by the Rocks(tm)
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
# Revision 1.4  2009/07/02 05:10:43  mahidhar
# Changed PGI roll to allow for non-interactive make roll.
# Removed src file; Will upload new one.
#
# Revision 1.3  2009/05/21 00:49:57  mahidhar
# Removed PGI rpm files
# Updated PGI xml, Makefile, version.mk
#
# Revision 1.1  2009/05/06 23:39:01  mahidhar
# *** empty log message ***
#
# Revision 1.7  2009/04/28 18:23:47  jhayes
# Remove disused include.
#
# Revision 1.6  2009/04/15 16:50:26  jhayes
# Allow specification of per-service monitoring timeperiod.  Remove copying of
# sample configuration to target.
#
# Revision 1.5  2009/03/27 22:58:28  jhayes
# Debugging.
#
# Revision 1.4  2009/03/26 21:26:50  jhayes
# Begin working on using rocks command to manipulate nagios config.
#
# Revision 1.3  2009/03/13 19:07:55  jhayes
# Clean up node XML and Makefile.
#
# Revision 1.2  2009/03/12 18:44:35  jhayes
# Initial version working on triton.
#
# Revision 1.1  2009/02/05 18:36:05  bruno
# added
#
#

PKGROOT = /opt/pgi
REDHAT.ROOT = $(PWD)/../../
RPM.EXTRAS=%define __os_install_post /usr/lib/rpm/brp-compress

-include $(ROCKSROOT)/etc/Rules.mk

build:

install::
	mkdir -p $(ROOT)/$(PKGROOT)
	(tardir=`pwd`; \
         mkdir -p $(ROOT)/$(PKGROOT)/TMP; \
	 cd $(ROOT)/$(PKGROOT)/TMP; \
	 tar zxvf $${tardir}/$(NAME)linux-$(VERSION).tar.gz)
	( \
	  cd $(ROOT)$(PKGROOT)/TMP; \
          echo $(ROOT)$(PKGROOT) > input.list; \
	  ./install-rocks < input.list; \
          mv install-rocks-post ../; \
          mv postinstall-rocks-post ../; \
          cd ../; \
          rm -rf TMP; \
	)

clean::
	rm -rf $(ROOT)/$(PKGROOT)
