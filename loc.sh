#!/bin/sh
find . -maxdepth 1 -name '*.rb' | xargs wc -l
