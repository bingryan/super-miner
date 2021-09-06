#!/usr/bin/env bash
set -u

echo "start limit cpu"

# sudo apt install cpulimit


# shellcheck disable=SC2034
sworker_pid=$(pidof crust-sworker)
if [ $? -ne 0 ]; then
    echo "sworker is not running, for detail: sudo crust status "
    exit 1
fi



sudo cpulimit --pid $sworker_pid --limit 80 --background
if [ $? -ne 0 ]; then
    echo "limit sworker cpu fail "
    exit 1
fi



crust_pid=$(pidof crust)
if [ $? -ne 0 ]; then
    echo "crust is not running, for detail: sudo crust status "
    exit 1
fi

sudo cpulimit --pid $crust_pid --limit 50 --background
if [ $? -ne 0 ]; then
    echo "limit crust cpu fail "
    exit 1
fi