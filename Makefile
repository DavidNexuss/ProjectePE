GCC = g++
CFLAGS = -I include/
LDFLAGS = -lcurl

OUT = bin/main

ODIR = obj
IDIR = src
SDIR = as

all: $(IDIR) $(ODIR) $(OUT) bin/extract

debug: OUT=bin/main-debug
debug: CFLAGS +=-g
debug: all

release: OUT=bin/main-release
release: CFLAGS +=-O2
release: all

bin/main: obj/main.o
	g++ $(LDFLAGS) $^ -o $@
obj/main.o: src/main.cc
	g++ $(CFLAGS) -c $^ -o $@
bin/extract: src/extract.cc
	g++ -O2 $^ -o $@
clean:
	rm bin/main
	rm bin/extract
	rm obj/*.o
