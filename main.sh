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

SAVE_PATH_LIST="$SAVE_PATH/list.json"

slack_conversation_list_wrapper $API_TOKEN | jq > $SAVE_PATH_LIST

echo "All channels id:"
for i in $(cat $SAVE_PATH_LIST | jq '.channels[].id')
do
    echo "$i" | sed -e 's/^"//' -e 's/"$//'
done
