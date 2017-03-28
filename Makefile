CC := clang++ -std=c++14 -I . -g -Werror -Wall

executable := executable
main_file := src/main.cc
src_files := $(filter-out $(main_file), $(wildcard src/*.cc src/**/*.cc))

unit_test_files := $(wildcard test/*.cc test/**/*.cc)
integration_test_files := $(wildcard test/*.py test/**/*.py)

compile_unit_tests := \
  $(CC) $(src_files) $(unit_test_files) \
	  -pthread -ldw -lgmock -lgmock_main


$(executable): $(src_files) $(main_file)
	$(CC) -O3 -o $@ $(src_files) $(main_file)

$(executable)_debug: $(src_files) $(main_file)
	$(CC) -o $@ $(src_files) $(main_file)

unit_tests: $(src_files) $(unit_test_files)
	$(compile_unit_tests) -o $@

unit_tests_opt: $(src_files) $(unit_test_files)
	$(compile_unit_tests) -o $@ -O3

# llvm-symbolize must be on your path for stack trace symbolization.
unit_tests_asan: $(src_files) $(unit_test_files)
	$(compile_unit_tests) -o $@ -fsanitize=address

# MSAN generates false positives unless libc++ and GTest were compiled for it.
unit_tests_msan: $(src_files) $(unit_test_files)
	$(compile_unit_tests) -o $@ -O2 -fsanitize=memory -fno-omit-frame-pointer

unit_tests_tsan: $(src_files) $(unit_test_files)
	$(compile_unit_tests) -o $@ -O2 -fsanitize=thread

clean:
	rm -f *.out $(executable)* unit_tests*
	rm -rf .cache test/__pycache__

run_unit_tests: unit_tests FORCE
	./unit_tests

run_unit_tests_opt: unit_tests_opt FORCE
	./unit_tests_opt

run_unit_tests_asan: unit_tests_asan FORCE
	./unit_tests_asan

run_unit_tests_msan: unit_tests_msan FORCE
	./unit_tests_msan

run_unit_tests_tsan: unit_tests_tsan FORCE
	./unit_tests_tsan

run_integration_tests: $(executable) FORCE
	pytest $(integration_test_files)

run_all_tests: \
		run_unit_tests \
		run_unit_tests_opt \
		run_unit_tests_asan \
		run_unit_tests_tsan \
		run_integration_tests

FORCE:
