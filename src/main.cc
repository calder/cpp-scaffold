#include <stdio.h>

#include "src/util.h"

int main(int argc, char* argv[]) {
  printf("Hello world!\n");

  for (int i = 1; i < argc; ++i) {
    for (std::string file : listFiles(argv[i])) {
      printf("%s\n", file.c_str());
    }
  }
}
