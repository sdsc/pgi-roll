ROLLNAME	= pgi
VERSION        :=$(shell bash version.sh -v)
RELEASE        :=$(shell bash version.sh -h)
COLOR		= orange

# Override default maximum iso size of 600MB
ISOSIZE = 700

REDHAT.ROOT = $(PWD)
