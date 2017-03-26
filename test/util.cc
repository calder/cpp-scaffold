#include <set>

#include "test/util.h"

std::set<Test*>& AllTests() {
  static std::set<Test*>* sAllTests = new std::set<Test*>();
  return *sAllTests;
}

Test::Test() {
  AllTests().insert(this);
}

Test::~Test() {
  AllTests().erase(this);
}

void Test::RunAll() {
  printf("Running %lu tests...\n", AllTests().size());
  for (auto* test : AllTests()) {
    test->Run();
  }
  printf("%lu tests passed.\n", AllTests().size());
}

void Test::Run() {
  printf("------------------------------------------------------------\n");
  printf("Starting test %s...\n", Name().c_str());
  Impl();
  printf("Completed test %s.\n", Name().c_str());
  printf("------------------------------------------------------------\n");
}
