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
#include <stdio.h>
 
const int N = 16; 
const int blocksize = 16; 
 
__global__ 
void hello(char *a, int *b) 
{
     a[threadIdx.x] += b[threadIdx.x];
}
 
int main()
{
     char a[N] = "Hello \0\0\0\0\0\0";
     int b[N] = {15, 10, 6, 0, -11, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 
     char *ad;
     int *bd;
     const int csize = N*sizeof(char);
     const int isize = N*sizeof(int);
 
     printf("%s", a);
 
     cudaMalloc( (void**)&ad, csize ); 
     cudaMalloc( (void**)&bd, isize ); 
     cudaMemcpy( ad, a, csize, cudaMemcpyHostToDevice ); 
     cudaMemcpy( bd, b, isize, cudaMemcpyHostToDevice ); 
     
     dim3 dimBlock( blocksize, 1 );
     dim3 dimGrid( 1, 1 );
     hello<<<dimGrid, dimBlock>>>(ad, bd);
     cudaMemcpy( a, ad, csize, cudaMemcpyDeviceToHost ); 
     cudaFree( ad );
     cudaFree( bd );
     
     printf("%s\\n", a);
     return EXIT_SUCCESS;
}
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
  ok($output =~ /Portland/, 'man works for pgi');

  SKIP: {
    skip 'CUDA_VISIBLE_DEVICES undef', 1
     if ! defined($ENV{'CUDA_VISIBLE_DEVICES'});
     $output = `module load pgi cuda/8.0; pgCC -I/opt/pgi/linux86-64/2017/cuda/8.0/include -Mcudax86 -o $TESTFILE $TESTFILE.cu 2>&1`;
     ok($? == 0, 'pgi CUDA/C++ compiler works');
     $output = `module load pgi cuda/8.0; ./$TESTFILE 2>&1`;
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

