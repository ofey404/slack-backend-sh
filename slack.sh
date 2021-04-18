#!/usr/bin/bash
# Shared functions for slack api.

source util.sh

# Hack: jq command can't be stored in a variable, due to shell word splitting.
# The only clean way I thought is to set a global variable.
# https://github.com/stedolan/jq/issues/1124
_jq_command_arr=()


function get_resp_to_tmp_files() {
    local api_link="$1"
    local api_token="$2"
    local tmp_filepath_prefix="$3"
    local optional_arguments="${@:4}"

    local i=1
    while :
    do
        if [[ -z "$next_cursor" ]]; then
            local data=$(join_arguments_www_form "token=$api_token" "$optional_arguments")
        else
            local data=$(join_arguments_www_form "token=$api_token" "cursor=$next_cursor" "$optional_arguments")
        fi

        resp=$(curl --silent -X POST -H "Authorization: Bearer $api_token" \
             -H "Content-type: application/x-www-form-urlencoded" \
             --data "$data"\
             $api_link)

        # if response is empty
        if [[ -z "$resp" ]]; then
            echo "ERROR: conversations.history on channel $channel response empty" 1>&2
            return 1
        fi

        # if not ok
        if [[ "$(echo $resp | jq '.ok')" != true ]]; then
            echo "ERROR: conversations.history on channel $channel not ok, response $resp" 1>&2
            return 1
        fi

        # allocate filename based on unique time stamp to tmp files
        local tmp_file_name="$tmp_filepath_prefix.$i.tmp"
        echo $resp | jq > $tmp_file_name

        # if no more data, break
        if [[ $(echo $resp | jq '.has_more') != true ]]; then
            break
        fi

        local next_cursor=$(echo $resp | jq '.response_metadata.next_cursor' | sed -e 's/^"//' -e 's/"$//')
        ((i++))
    done

    return 0
}


# -- WARNING: This function contains some hacky tricks! --
#
# Glue tmp files in a reduce style.
#   pass accumulating command with global variable `_jq_command_arr`
# 
# Usage:
#     _jq_command_arr=( jq -s '{channel: .[0].channel, messages: (.[0].messages + .[1].messages) }' )
#     glue_tmp_files $filepath_prefix \
#                    $output_filepath \
#                    $initial_output_file_content
# 
# Hack: jq command can't be stored in a variable, due to shell word splitting.
# The only clean way I thought is to set a global variable.
# https://github.com/stedolan/jq/issues/1124
function glue_tmp_files() {
    local tmp_filepath_prefix="$1"
    local output_filepath="$2"
    shift 2
    local initial_output_file_content="$@"

    local tmp_dir=$(dirname "$tmp_filepath_prefix")
    local output_tmpfile="$output_filepath.tmp"

    echo "$initial_output_file_content" | jq > $output_filepath

    # filter only paths match given prefix
    for path in $(ls_relative_path_natural_sort ${tmp_dir} | grep ${tmp_filepath_prefix})
    do
        "${_jq_command_arr[@]}" $output_filepath $path > $output_tmpfile
        cp $output_tmpfile $output_filepath
    done

    rm $output_tmpfile
    return 0
}
