# SDSC "pgi" roll

## Overview

This roll bundles the installation of compilers which are part of the PGI Workstation(tm) suite for x64.

**NOTE: The actual compilers and licenses must be obtained from The Portland Group directly as this roll only wraps the compilers into a Rocks roll for installation into a Rocks cluster.**

For more information about PGI Compilers please visit the official web pages of
<a href="http://www.pgroup.com" target="_blank">The Portland Group</a>.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

In addition, non-SDSC users must also place a `tar.gz` bundle of the PGI
installation source provided by The Portland Group in the `src/pgi` directory.
That file should be named to match the pattern listed in `src/pgi/version.mk`
and the `version.mk` file should be edited appropriately.
Unless you are building a different compiler version than is expected by the
roll sources, a simple gzip of the tar file downloaded from the Portland Group
website should fulfill this requirement.


## Dependencies

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.


## Building

To build the pgi-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `mono-*.disk1.iso`.  If you built the
roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll pgi
% cd /export/rocks/install
% rocks create distro
```

Subsequent installs of compute and login nodes will then include the contents
of the pgi-roll.  To avoid cluttering the cluster frontend with unused
software, the pgi-roll is configured to install only on compute and
login nodes. To force installation on your frontend, run this command after
adding the pgi-roll to your distro

```shell
% rocks run roll pgi host=NAME | bash
```

where NAME is the DNS name of a compute or login node in your cluster.

In addition to the software itself, the roll installs package environment
module files in:

```shell
/opt/modulefiles/compilers/pgi
```



## Testing

The pgi-roll includes a test script which can be run to verify proper
installation of the pgi-roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/pgi.t 
```
