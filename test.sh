#!/bin/sh

FILES='**/*.cc **/*.h **/*.py test/cases Makefile'

while true; do
  inotifywait -r -e close_write --format 'Detected change: %w%f' $FILES \
    || exit 1
  make run_all_tests
done
