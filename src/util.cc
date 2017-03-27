#include <algorithm>
#include <dirent.h>

#include "src/util.h"

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
