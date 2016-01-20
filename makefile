MODEL = 64
DMDDIR = $(HOME)/local/dmd-2.069.2/linux
PATH = $(DMDDIR)/bin$(MODEL):/usr/bin:/bin
run: dmain cmain

main: main.c
	gcc -m$(MODEL) -fPIC $^ -ldl -o main

cmain: main foo.so
	./main

dmain: foo.d
	$(DMDDIR)/bin$(MODEL)/rdmd foo.d

link.o: link.c
	gcc -m$(MODEL) -fPIC -o $@ -c -I. $<

foo.so: foo.d link.o
	$(DMDDIR)/bin$(MODEL)/dmd -fPIC -shared -of$@ -L-ldl -L-lphobos2 -L-R$(DMDDIR)/lib$(MODEL) $^

clean:
	rm -f foo.so foo.o link.o main
