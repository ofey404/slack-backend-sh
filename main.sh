#!/usr/bin/bash
# Global entry of message backuper.

# Uncomment those code while debugging.
# set -x
# trap read debug

source util.sh
source api_conversations_list.sh
source api_users_list.sh
source api_conversations_join.sh
source api_conversations_history.sh
source api_conversations_replies.sh

API_TOKEN=$(init_parameter API_TOKEN)
SAVE_PATH=$(init_parameter SAVE_PATH ./data)

mkdir -p $SAVE_PATH

LIST_FILE_PATH="$SAVE_PATH/list.json"
USERS_FILE_PATH="$SAVE_PATH/users.json"

# list all conversations, save to a file
slack_conversations_list_wrapper $API_TOKEN | jq > $LIST_FILE_PATH

# list all users, save to a file
slack_users_list_wrapper $API_TOKEN | jq > $USERS_FILE_PATH

# try to join all visible channel
join_all_channels_from_list_file $API_TOKEN $LIST_FILE_PATH > /dev/null

# get all conversations history concurrently
function get_history() {
    local channel_id="$1"

    output_filepath=$(slack_conversations_history_wrapper $API_TOKEN $channel_id)
    cp "$output_filepath" "$SAVE_PATH/conversation_history_${channel_id}.json"
    echo "get history of id $channel_id, channel $(channel_name_from_id ${channel_id} ${LIST_FILE_PATH})"
}

i=1
pids=()
for channel_id in $(all_channel_id_from_list_file $LIST_FILE_PATH)
do
    get_history $channel_id &
    pids[$i]=$!
    ((i++))
done

for pid in ${pids[@]}
do
    wait $pid
done

# get all replies
for history_filename in $(ls data/ | grep conversation_history)
do
    history_path="./data/$history_filename"
    get_all_replies_from_channel $API_TOKEN $history_path 
    id=$(cat $history_path | jq --raw-output '.channel')
    name=$(channel_name_from_id $id ${LIST_FILE_PATH})
    echo "get replies from channel $name"
done

