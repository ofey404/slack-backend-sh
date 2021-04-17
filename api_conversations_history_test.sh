#!/usr/bin/bash

source assert.sh
source api_conversations_list.sh

# conversation.list
# https://api.slack.com/methods/conversations.list
assert_end api_conversations_list
