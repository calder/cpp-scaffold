#include <cassert>
#include <cstdio>
#include <functional>
#include <map>
#include <memory>
#include <string>

#define TEST(NAME, CODE) \
  Test NAME{""#NAME, CODE};

class Test
{
public:
  static void RunAll() {
    printf("Running %lu tests...\n", TestMap().size());
    for (auto pair : TestMap()) {
      pair.second->Run();
    }
    printf("%lu tests passed.\n", TestMap().size());
  }

  Test(const std::string& name, std::function<void()> func) :
      mName(name), mFunc(func) {
    assert(TestMap().count(name) == 0);
    TestMap()[name] = this;
  }

  virtual ~Test() {
    TestMap().erase(mName);
  }

private:
  void Run() {
    printf("----------------------------------------\n");
    printf("Starting %s...\n", mName.c_str());
    mFunc();
    printf("Completed %s.\n", mName.c_str());
    printf("----------------------------------------\n");
  }

  static std::map<std::string, Test*>& TestMap();

  const std::string mName;
  const std::function<void()> mFunc;
};
