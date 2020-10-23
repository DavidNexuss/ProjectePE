GCC = g++
CFLAGS = -I include/
LDFLAGS = -lcurl

OUT = bin/main

ODIR = obj
IDIR = src
SDIR = as

all: $(IDIR) $(ODIR) $(OUT)

debug: OUT=bin/main-debug
debug: CFLAGS +=-g
debug: all

release: OUT=bin/main-release
release: CFLAGS +=-O2
release: all

run: all
	./$(OUT)
$(ODIR):
	mkdir $(ODIR)
$(IDIR):
	mkdir $(IDIR)
$(SDIR):
	mkdir $(SDIR)

C_SOURCES = $(shell find $(IDIR) -type f -name *.cc -printf "%f\n")
OBJECTS = $(patsubst %.cc, $(ODIR)/%.o,$(C_SOURCES))
S_CODE = $(patsubst %.cc, $(SDIR)/%.s,$(C_SOURCES))

$(ODIR)/%.o : $(IDIR)/%.cc
	$(GCC) $(CFLAGS) -c $^ -o $@

$(SDIR)/%.s : $(IDIR)/%.cc
	$(GCC) -g -o $@ $(CFLAGS) -S $^

$(ODIR)/%.o : $(IDIR)/**/%.cc
	$(GCC) $(CFLAGS) -c $^ -o $@

$(SDIR)/%.s : $(IDIR)/**/%.cc
	$(GCC) -g -o $@ $(CFLAGS) -S $^


$(OUT): $(OBJECTS)
	$(GCC) $(LDFLAGS) -o $(OUT) $(OBJECTS)

clean: $(ODIR)
	rm -rf $(ODIR)
	rm -rf $(SDIR)

clean-dis: $(SDIR)
	rm -rf $(SDIR)

dis: all $(SDIR) $(S_CODE)
