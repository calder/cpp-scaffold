import pytest
import os
import subprocess

def exec(*args):
  stdout = subprocess.check_output(["./executable", *args])
  return stdout.decode("unicode_escape")

def test_output():
  assert exec() == "Hello world!\n"
