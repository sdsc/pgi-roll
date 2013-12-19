# SDSC "pgi" roll

## Overview

This roll bundles the installation of compilers which are part of the PGI Workstation(tm) suite for x64.

**NOTE: The actual compilers and licenses must be obtained from The Portland Group directly as this roll only wraps the compilers into a Rocks roll for installation into a Rocks cluster.**

For more information about PGI Compilers please visit the official web pages of
<a href="http://www.pgroup.com" target="_blank">The Portland Group</a>.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

In addition, non-SDSC users must also place a `tar.gz` bundle of the PGI installation source provided by The Portland Group in the `src/pgi` directory. That file should be named to match the pattern listed in `src/pgi/version.mk` and the `version.mk` file should be edited appropriately.


## Dependencies

Unknown at this time.


## Building

To build the pgi-roll, execute these instructions on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make default 2>&1 | tee build.log
% grep "RPM build error" build.log
```

If nothing is returned from the grep command then the roll should have been
created as... `pgi-*.iso`. If you built the roll on a Rocks frontend then
proceed to the installation step. If you built the roll on a Rocks development
appliance you need to copy the roll to your Rocks frontend before continuing
with installation.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll pgi
% cd /export/rocks/install
% rocks create distro
% rocks run roll pgi | bash
```

In addition to the software itself, the roll installs pgi environment
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
ok 1 - pgi compilers installed
ok 2 - pgi C compiler works
ok 3 - compiled C program runs
ok 4 - compile C program correct output
ok 5 - pgi FORTRAN compiler works
ok 6 - compiled FORTRAN program runs
ok 7 - compile FORTRAN program correct output
ok 8 - man works for pgi
ok 9 - pgi module installed
ok 10 - pgi version module installed
ok 11 - pgi version module link created
1..11
```
