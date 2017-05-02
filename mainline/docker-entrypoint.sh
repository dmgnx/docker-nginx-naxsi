#!/bin/sh

if test "x${1:0:1}" = "x-" 
then
    exec nginx "$@"
else
    exec "$@"
fi
