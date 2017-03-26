CC := clang++ -std=c++14 -I .

src_files := $(wildcard src/**.cc)
test_files := $(wildcard test/**.cc)

default: test

test: $(src_files) $(test_files)
	$(CC) -o test.out -g $(src_files) $(test_files)
