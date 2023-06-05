#!/usr/bin/env bash

echo -n "${1},1" | md5sum | awk '{print $1}'
