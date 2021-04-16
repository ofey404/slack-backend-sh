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

slack_conversation_list_wrapper $API_TOKEN | jq > $LIST_FILE_PATH

all_channel_id_from_list_file $LIST_FILE_PATH
