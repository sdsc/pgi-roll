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

open(OUT, ">$TESTFILE.cu");
print OUT <<END;
!
!     Copyright (c) 2017, NVIDIA CORPORATION.  All rights reserved.
!
! NVIDIA CORPORATION and its licensors retain all intellectual property
! and proprietary rights in and to this software, related documentation
! and any modifications thereto.
!
!
!    These example codes are a portion of the code samples from the companion
!    website to the book "CUDA Fortran for Scientists and Engineers":
!
! http://store.elsevier.com/product.jsp?isbn=9780124169708
!
module simpleOps_m
contains
  attributes(global) subroutine increment(a, b)
    implicit none
    integer, intent(inout) :: a(:)
    integer, value :: b
    integer :: i

    i = threadIdx%x
    a(i) = a(i)+b

  end subroutine increment
end module simpleOps_m


program incrementTest
  use cudafor
  use simpleOps_m
  implicit none
  integer, parameter :: n = 256
  integer :: a(n), b
  integer, device :: a_d(n)

  a = 1
  b = 3

  a_d = a
  call increment<<<1,n>>>(a_d, b)
  a = a_d

  if (any(a /= 4)) then
     write(*,*) '**** Program Failed ****'
  else
     write(*,*) 'Program Passed'
  endif
end program incrementTest

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
  $output = `module load pgi; pgcc -o $TESTFILE $TESTFILE.c 2>&1`;
  ok($? == 0, 'pgi C compiler works');
  $output = `module load pgi; ./$TESTFILE`;
  ok($? == 0, 'compiled C program runs');
  like($output, qr/Hello world/, 'compile C program correct output');
  
  $output = `module load pgi; pgf77 -o $TESTFILE $TESTFILE.f 2>&1`;
  ok($? == 0, 'pgi FORTRAN compiler works');
  $output = `module load pgi; ./$TESTFILE`;
  ok($? == 0, 'compiled FORTRAN program runs');
  like($output, qr/Hello world/, 'compile FORTRAN program correct output');

  $output = `module load pgi; man pgcc 2>&1`;
  ok($output =~ /PGI ANSI/, 'man works for pgi');

  SKIP: {
    skip 'CUDA_VISIBLE_DEVICES undef', 1
     if ! defined($ENV{'CUDA_VISIBLE_DEVICES'});
     $output = `module load pgi CUDAVERSION; pgc++  -Mcudax86 -o $TESTFILE $TESTFILE.cu 2>&1`;
     ok($? == 0, 'pgi CUDA/C++ compiler works');
     $output = `module load pgi CUDAVER; ./$TESTFILE 2>&1`;
     ok($? == 0, 'compiled CUDA/C++  program runs');
     like($output, qr/Hello World!/, 'compile CUDA/C++ program correct output');
  }

  
  `/bin/ls /opt/modulefiles/compilers/pgi/[0-9]* 2>&1`;
  ok($? == 0, 'pgi module installed');
  `/bin/ls /opt/modulefiles/compilers/pgi/.version.[0-9]* 2>&1`;
  ok($? == 0, 'pgi version module installed');
  ok(-l '/opt/modulefiles/compilers/pgi/.version',
     'pgi version module link created');

}

