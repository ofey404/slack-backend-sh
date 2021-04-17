#!/usr/bin/bash

source assert.sh
source api_users_list.sh

# users.list
# https://api.slack.com/methods/users.list
# output=$(cat test_data/user_info.output)
# assert "extract_users_info_from_users_file test_data/users.json" $output

assert_end api_users_list
