# memerr
Reduced code for memory corruption test case.

To reproduce the error, point the DMDDIR in the makefile to your
dmd-2.069.2 installation. And then run make.

I have tested the code on two ubuntu 14.04 64-bit machines and on both
the machines I get:


	$ make
	/home/puneet/local/dmd-2.069.2/linux/bin64/rdmd foo.d
	Start frop from D
	Successfully completed loop....
	./main
	Start frop from C
	0 -> @�+----------------


The text on the last line varies from one run to another. If you take
a look at foo.d, you will make out that the text corresponds to
corrupted contents of an array.

Note that I am able to reproduce the memory corruption only when I
create a shared library file for the D code and load it from C. Unless
I am making some non-obvious mistake in loading the dynamic library,
it seems to be a bug in DMD.
