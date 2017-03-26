#include <cassert>
#include <cstdio>
#include <string>

#define TEST(NAME)                                    \
  class Test__##NAME : public Test {                  \
  public:                                             \
    std::string Name() override;                      \
    void Impl() override;                             \
  };                                                  \
  Test__##NAME sTest__##NAME;                         \
  std::string Test__##NAME::Name() { return #NAME; }  \
  void Test__##NAME::Impl()

class Test
{
public:
  static void RunAll();

  Test();
  virtual ~Test();

protected:
  virtual std::string Name() = 0;
  virtual void Impl() = 0;

private:
  void Run();
};
