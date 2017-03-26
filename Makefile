CC := clang++ -std=c++14 -I .

executable_name := executable
main_file := src/main.cc
src_files := $(filter-out $(main_file), $(wildcard src/**.cc))
test_files := $(wildcard test/**.cc)

build: $(src_files)
	$(CC) -o $(executable_name) $(src_files) $(main_file)

test: $(src_files) $(test_files)
	$(CC) -o run_tests $(src_files) $(test_files) \
	  -g -pthread -lgmock -lgmock_main
