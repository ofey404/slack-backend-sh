#!/usr/bin/bash

source assert.sh
source slack.sh

VERBOSE=true

assert "join_arguments_www_form test1=1 test2=2" "test1=1&test2=2"
assert "join_arguments_www_form" ""

assert_end slack_test


if $VERBOSE
then
    source util.sh
    API_TOKEN=$(init_parameter API_TOKEN)

    echo $(slack_conversation_list_wrapper $API_TOKEN | jq)
    echo $(slack_conversation_list_wrapper $API_TOKEN "limit=1" | jq)
fi

