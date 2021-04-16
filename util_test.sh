#!/usr/bin/bash

source util.sh
source assert.sh

VERBOSE=false

if $VERBOSE
then
    API_TOKEN=$(init_parameter API_TOKEN)
    echo $API_TOKEN
    API_TOKEN=$(init_parameter API)
    echo $API_TOKEN
fi

assert "join_arguments_www_form test1=1 test2=2" "test1=1&test2=2"
assert "join_arguments_www_form" ""

assert_end util
