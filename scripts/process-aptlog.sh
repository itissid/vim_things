#!/bin/bash

cat apt-install.log |  sed -E 's/, automatic\)/\)/g'  |   sed 's/, /\n/g' | sed -E 's/\([^()]*\)//g' | sed 's/:amd64//g' |  sed 's/^[[:space:]]*//;s/[[:space:]]*$//' |sort -u
