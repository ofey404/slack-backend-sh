#!/usr/bin/bash
# Interacting with slack api.

source util.sh
source slack.sh

# conversation.replies
# https://api.slack.com/methods/conversations.replies

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
    local output_filepath="$tmp_filepath_prefix.output.tmp"
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
