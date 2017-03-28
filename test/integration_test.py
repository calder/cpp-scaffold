import glob
import pytest
import os
import subprocess

def exec(*args):
  stdout = subprocess.check_output(["./executable", *args])
  return stdout.decode("unicode_escape")

def test_default():
  assert exec() == "Hello world!\n"

@pytest.mark.parametrize("expected_file", glob.glob("test/cases/*.expected"))
def test_with_arg(expected_file):
  expected = open(expected_file).read()
  dir = expected_file.split(".")[0]
  assert exec(dir) == expected
