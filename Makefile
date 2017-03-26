CC := clang++ -std=c++14 -I .

executable := executable
test_executable := run_tests
main_file := src/main.cc
src_files := $(filter-out $(main_file), $(wildcard src/**.cc))
test_files := $(wildcard test/**.cc)

clean:
	rm *.out $(executable) $(test_executable)

build: $(src_files) $(main_file)
	$(CC) -o $(executable_name) $(src_files) $(main_file)

test: $(src_files) $(test_files)
	$(CC) -o $(test_executable) $(src_files) $(test_files) \
	  -g -pthread -lgmock -lgmock_main
