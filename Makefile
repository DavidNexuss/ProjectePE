GCC = g++
CFLAGS = -I include/
LDFLAGS = -lcurl

BIN= extract fragmentat clear

%: src/%.cc
	g++ -O2 $^ -o $@

all: $(BIN)
run: all
	./test.bash <<< "4"
clean:
	rm $(BIN)
