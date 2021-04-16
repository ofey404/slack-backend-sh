#!/usr/bin/bash
# Global entry of message backuper.

# Uncomment those code while debugging.
# set -x
# trap read debug

source util.sh
source slack.sh

API_TOKEN=$(init_parameter API_TOKEN)
SAVE_PATH=$(init_parameter SAVE_PATH ./data)

mkdir -p $SAVE_PATH

LIST_FILE_PATH="$SAVE_PATH/list.json"
USERS_FILE_PATH="$SAVE_PATH/users.json"

slack_conversations_list_wrapper $API_TOKEN | jq > $LIST_FILE_PATH
slack_users_list_wrapper $API_TOKEN | jq > $USERS_FILE_PATH

all_channel_id_from_list_file $LIST_FILE_PATH
extract_users_info_from_users_file $USERS_FILE_PATH
