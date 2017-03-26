#include "test/util.h"

std::unique_ptr<std::map<std::string, Test*>> Test::sTestMap;

std::map<std::string, Test*>& Test::TestMap() {
  if (!sTestMap) {
    sTestMap = std::make_unique<std::map<std::string, Test*>>();
  }
  return *sTestMap;
}
