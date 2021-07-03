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

# Set api token and save path from command line, if possible.
if [[ -z "$API_TOKEN" ]]; then
    API_TOKEN=$(init_parameter API_TOKEN)
fi

if [[ -z "$SAVE_PATH" ]]; then
    SAVE_PATH=$(init_parameter SAVE_PATH ./data)
fi

rm -rf ./tmp

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

    oldest=$(cat "$SAVE_PATH/conversations_history_${channel_id}.json" | jq --raw-output '.messages[0].ts')

    output_filepath=$(slack_conversations_history_wrapper $API_TOKEN $channel_id "oldest=$oldest")
    cp "$output_filepath" "$SAVE_PATH/conversations_history_${channel_id}.json.tmp"
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
for tmp_history_filename in $(ls $SAVE_PATH | egrep '^conversations_history_.+?\.json\.tmp$')
do
    history_path="./data/$tmp_history_filename"
    get_all_replies_from_channel $API_TOKEN $history_path 
    id=$(cat $history_path | jq --raw-output '.channel')
    name=$(channel_name_from_id $id ${LIST_FILE_PATH})
    echo "get replies from channel $name"
done

# merge replies and histories.
for history_filename in $(ls data/ | egrep '^conversations_history_.+?.json$')
do
    history_path="./data/$history_filename"
    jq -s '{channel: .[0].channel, messages: (.[1].messages + .[0].messages) }' "$history_path" "$history_path.tmp" > "$history_path.tmp.output"
    mv "$history_path.tmp.output" "$history_path"
    rm "$history_path.tmp"
done


for replies_filename in $(ls data/ | egrep '^conversations_replies_.+?.json$')
do
    replies_path="./data/$replies_filename"

    jq -s '{channel: .[0].channel, reply_threads: (.[0].reply_threads + .[1].reply_threads) }' "$replies_path" "$replies_path.tmp" > "$replies_path.tmp.output"
    mv "$replies_path.tmp.output" "$replies_path"
    rm "$replies_path.tmp"
done
