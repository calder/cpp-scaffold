CC := clang++ -std=c++14 -I . -g

executable := executable
main_file := src/main.cc
src_files := $(filter-out $(main_file), $(wildcard src/**.cc))

unit_test_executable := run_unit_tests
unit_test_files := $(wildcard tests/**.cc)
integration_test_files := $(wildcard tests/**.py)

debug: $(src_files) $(main_file)
	$(CC) -o $(executable) $(src_files) $(main_file)

test: $(src_files) $(unit_test_files)
	$(CC) -o $(unit_test_executable) $(src_files) $(unit_test_files) \
	  -pthread -ldw -lgmock -lgmock_main

clean:
	rm *.out $(executable) $(unit_test_executable)

run-unit-tests: test FORCE
	./$(unit_test_executable)

run-integration-tests: FORCE
	pytest $(integration_test_files)

run-all-tests: run-unit-tests run-integration-tests

FORCE:
