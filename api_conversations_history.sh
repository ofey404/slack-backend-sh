#!/usr/bin/bash
# Interacting with slack api.

source util.sh
source slack.sh

# conversation.history
# https://api.slack.com/methods/conversations.history

# Get all history from a channel, store in some tmp files and glue them together.
# Return:
#   Path to final history file.
function slack_conversations_history_wrapper() {
    local api_token="$1"
    local channel="$2"
    local optional_arguments="${@:3}"

    # Write response to tmp files
    mkdir -p ./tmp
    local tmp_filepath_prefix="./tmp/conversations_history_${channel}_$(date +%Y-%m-%d-%H-%M-%S)"
    # TODO: catch none 0 return value
    history_get_resp_to_tmp_files $api_token $channel $tmp_filepath_prefix

    # glue tmp files together.
    local output_filepath="$tmp_filepath_prefix.output.tmp"
    history_glue_tmp_files $channel $tmp_filepath_prefix $output_filepath

    echo $output_filepath
    return 0
}

# Query api, store with `tmp_filepath_prefix`
# eg:
#   tmp_filepath_prefix="./tmp/resp"
#   tmp files:
#   - ./tmp/resp.1.tmp
#   - ./tmp/resp.2.tmp
#   - ./tmp/resp.3.tmp
function history_get_resp_to_tmp_files() {
    local api_token="$1"
    local channel="$2"
    local tmp_filepath_prefix="$3"
    
    local history_api_link="https://slack.com/api/conversations.history"
    get_resp_to_tmp_files $history_api_link \
                          $api_token \
                          $tmp_filepath_prefix \
                          "channel=$channel"
}


# Filter tmp files, glue them together in a natural sort order. 
#   (*Natural sort order* ref to `function ls_relative_path_natural_sort()`)
# Then merge them into a output file:
#   {
#     "channel": "$channel",
#     "messages": []
#   }
function history_glue_tmp_files() {
    local channel="$1"
    local tmp_filepath_prefix="$2"
    local output_filepath="$3"

    # Another magic here... I still don't find the correct way
    # to escape two successive brackets.
    # $ a='[]'; echo $a
    # 
    # $ a='[ ]'; echo $a
    # [ ]
    initial_output_file_content="{ \"channel\": \"${channel}\", \"messages\": [ ] }" 

    # Hack! ref definition of `glue_tmp_files`
    _jq_command_arr=( jq -s '{channel: .[0].channel, messages: (.[0].messages + .[1].messages) }' )
    glue_tmp_files $tmp_filepath_prefix \
                   $output_filepath \
                   $initial_output_file_content
    return 0
}
