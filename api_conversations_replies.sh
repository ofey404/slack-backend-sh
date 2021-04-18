#!/usr/bin/bash
# Interacting with slack api.

source util.sh

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
    local filepath_prefix="./tmp/conversations_replies_${channel}_${ts}_$(date +%Y-%m-%d-%H-%M-%S)"
    # TODO: catch none 0 return value
    replies_get_resp_to_tmp_files $api_token $channel $filepath_prefix

    # glue tmp files together.
    local output_filepath="$filepath_prefix.output.tmp"
    replies_glue_tmp_files $channel $filepath_prefix $output_filepath

    echo $output_filepath
    return 0
}


