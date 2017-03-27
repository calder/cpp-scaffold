#include <algorithm>
#include <dirent.h>
#include <stdio.h>
#include <string>
#include <vector>

std::vector<std::string> listFiles(const std::string& path) {
  std::vector<std::string> files;
  DIR* dir = opendir(path.c_str());
  if (!dir) { return files; }

  while (dirent* entry = readdir(dir)) {
    std::string file = entry->d_name;
    if (file != "." && file != "..") {
      files.push_back(file);
    }
  }

  closedir(dir);
  std::sort(files.begin(), files.end());
  return files;
}

int main(int argc, char* argv[]) {
  printf("Hello world!\n");
  for (int i = 1; i < argc; ++i) {
    for (std::string file : listFiles(argv[i])) {
      printf("%s\n", file.c_str());
    }
  }
}
