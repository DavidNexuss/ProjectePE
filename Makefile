GCC = g++
CFLAGS = -I include/
LDFLAGS = -lcurl

BIN= extract fragmentat

%: src/%.cc
	g++ -O2 $^ -o $@

all: $(BIN)
run: all
	@echo "Atenció: Aquest procés complet pot durar hores"
	./query.bash 2013 2020 > repos_cut.txt
	./test.bash <<< "4"
clean:
	rm -f $(BIN) repos_cut.txt
