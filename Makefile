GCC = g++
CFLAGS = -I include/
LDFLAGS = -lcurl

BIN=extract fragmentat

%: src/%.cc
	g++ -O2 $^ -o $@

all: $(BIN)
clean:
	rm $(BIN)
