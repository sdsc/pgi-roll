#!/usr/bin/perl -w
# pgi roll installation test.  Usage:
# pgi.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/pgi';
my $output;

my $TESTFILE = 'tmppgi';

open(OUT, ">$TESTFILE.c");
print OUT <<END;
#include <stdio.h>
int main(char **args) {
  printf("Hello world\\n");
  return 0;
}
END
open(OUT, ">$TESTFILE.f");
print OUT <<END;
      PROGRAM HELLO
      PRINT*, 'Hello world!'
      END
END
close(OUT);

# pgi-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'pgi compilers installed');
} else {
  ok(! $isInstalled, 'pgi compilers not installed');
}
SKIP: {

  skip 'pgi compilers not installed', 10 if ! $isInstalled;
  my $modulesInstalled = -f '/etc/profile.d/modules.sh';
  my $setup = $modulesInstalled ?
              ". /etc/profile.d/modules.sh; module load pgi" :
              'echo > /dev/null'; # noop
  $output = `$setup; pgcc -o $TESTFILE $TESTFILE.c 2>&1`;
  ok($? == 0, 'pgi C compiler works');
  $output = `$setup; ./$TESTFILE`;
  ok($? == 0, 'compiled C program runs');
  like($output, qr/Hello world/, 'compile C program correct output');
  
  $output = `$setup; pgf77 -o $TESTFILE $TESTFILE.f 2>&1`;
  ok($? == 0, 'pgi FORTRAN compiler works');
  $output = `$setup; ./$TESTFILE`;
  ok($? == 0, 'compiled FORTRAN program runs');
  like($output, qr/Hello world/, 'compile FORTRAN program correct output');

  $output = `$setup; man pgcc 2>&1`;
  ok($output =~ /Portland/, 'man works for pgi');
  
  skip 'modules not installed', 3 if ! $modulesInstalled;
  `/bin/ls /opt/modulefiles/compilers/pgi/[0-9]* 2>&1`;
  ok($? == 0, 'pgi module installed');
  `/bin/ls /opt/modulefiles/compilers/pgi/.version.[0-9]* 2>&1`;
  ok($? == 0, 'pgi version module installed');
  ok(-l '/opt/modulefiles/compilers/pgi/.version',
     'pgi version module link created');

}

`rm -f $TESTFILE*`;
