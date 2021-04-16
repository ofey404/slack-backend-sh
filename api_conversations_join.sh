#!/bin/bash

source util.sh

# conversations.join
# https://api.slack.com/methods/conversations.join

function slack_conversations_join_wrapper() {
    local api_token="$1"
    local channel="$2"
    local optional_arguments="${@:3}"

    local data=$(join_arguments_www_form "token=$api_token" "channel=$channel" "$optional_arguments")

    resp=$(curl --silent -X POST -H "Authorization: Bearer $api_token" \
         -H "Content-type: application/x-www-form-urlencoded" \
         --data "$data"\
         https://slack.com/api/conversations.join)

    if [[ "$(echo $resp | jq '.ok')" == false ]]; then
        echo "ERROR: conversation.join error, on channel $2, response $resp" 1>&2
        exit 1
    fi

    echo $resp
    return 0
}


# Join all channels id mentioned in list file concurrently
#   WARNING: It's verbose! use `> /dev/null` to make it quiet.
function join_all_channels_from_list_file() {
    local api_token="$1"
    local list_file_path="$2"

    local i=1
    local pids=()
    for channel in $(all_channel_id_from_list_file $list_file_path)
    do
        slack_conversations_join_wrapper $api_token $channel &
        pids[$i]=$!
        ((i++))
    done

    for pid in ${pids[*]}
    do
        wait $pid
    done
}
