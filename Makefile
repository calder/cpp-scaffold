CC := clang++ -std=c++14 -I . -g -Werror -Wall

executable := executable
main_file := src/main.cc
src_files := $(filter-out $(main_file), $(wildcard src/**.cc))

unit_test_files := $(wildcard test/**.cc)
integration_test_files := $(wildcard tests/**.py)

$(executable): $(src_files) $(main_file)
	$(CC) -o -O4 $(executable) $(src_files) $(main_file)

debug: $(src_files) $(main_file)
	$(CC) -o debug $(src_files) $(main_file)

unit_tests: $(src_files) $(unit_test_files)
	echo $(src_files) $(unit_test_files)
	$(CC) -o unit_tests $(src_files) $(unit_test_files) \
	  -pthread -ldw -lgmock -lgmock_main

clean:
	rm *.out $(executable) unit_tests

run_unit_tests: unit_tests FORCE
	./unit_tests

run_integration_tests: debug FORCE
	pytest $(integration_test_files)

run_all_tests: run_unit_tests run_integration_tests

FORCE:
