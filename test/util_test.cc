#include <gmock/gmock.h>

#include "src/util.h"

using testing::ElementsAre;

TEST(UtilTest, ListFiles) {
  EXPECT_THAT(listFiles("test/samples/test1"),
              ElementsAre("bar", "baz", "foo"));
}
