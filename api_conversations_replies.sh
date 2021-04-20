#!/usr/bin/bash
# Interacting with slack api.

source util.sh
source slack.sh

# conversation.replies
# https://api.slack.com/methods/conversations.replies

function get_all_replies_from_channel() {
    local api_token="$1"
    local history_file_path="$2"

    local channel=$(cat $history_file_path | jq --raw-output '.channel')
    mkdir -p ./tmp

    for ts in $(all_ts_has_reply_from_history_file $history_file_path)
    do
        # Api limit: 50 times per minute
        # TODO: If one conversation use too many pages, it will use up all api limits.
        response_filepath=$(slack_conversations_replies_wrapper $api_token $channel $ts)
        echo "get response of channel $channel ts $ts"
        sleep 2
    done

    local all_replies_prefix="./tmp/conversations_replies_all_${channel}"
    local output_filepath="./data/conversations_replies_${channel}.json.tmp"

    initial_output_file_content="{ \"channel\": \"${channel}\", \"reply_threads\": [ ] }"
    _jq_command_arr=( jq -s '{channel: .[0].channel, reply_threads: (.[0].reply_threads + [ .[1] ])}' )
    glue_tmp_files $all_replies_prefix \
                   $output_filepath \
                   $initial_output_file_content

    echo "$output_filepath"
}

# Get all history from a channel, store in some tmp files and glue them together.
# Return:
#   Path to final history file.
function slack_conversations_replies_wrapper() {
    local api_token="$1"
    local channel="$2"
    local ts="$3"
    local optional_arguments="${@:4}"

    # Write response to tmp files
    mkdir -p ./tmp
    local tmp_filepath_prefix="./tmp/conversations_replies_${channel}_${ts}_$(date +%Y-%m-%d-%H-%M-%S)"

    get_resp_to_tmp_files "https://slack.com/api/conversations.replies" \
                          $api_token \
                          $tmp_filepath_prefix \
                          "channel=$channel" "ts=$ts"

    # glue tmp files together.
    local output_filepath="./tmp/conversations_replies_all_${channel}_${ts}.tmp"
    replies_glue_tmp_files $channel $ts $tmp_filepath_prefix $output_filepath

    echo $output_filepath
    return 0
}

function replies_glue_tmp_files() {
    local channel="$1"
    local ts="$2"
    local tmp_filepath_prefix="$3"
    local output_filepath="$4"

    initial_output_file_content="{ \"ts\": \"${ts}\", \"channel\": \"${channel}\", \"messages\": [ ] }" 

    # Hack! ref definition of `glue_tmp_files`
    _jq_command_arr=( jq -s '{ts: .[0].ts, channel: .[0].channel, messages: (.[0].messages + .[1].messages) }' )
    glue_tmp_files $tmp_filepath_prefix \
                   $output_filepath \
                   $initial_output_file_content
    return 0
}

function all_ts_has_reply_from_history_file() {
    local history_file_path="$1"

    cat $history_file_path | jq --raw-output '.messages[] | select(has("reply_count")) | .ts'
}
