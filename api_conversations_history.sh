#!/usr/bin/bash
# Interacting with slack api.

source util.sh

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
    local filepath_prefix="./tmp/conversations_history_${channel}_$(date +%Y-%m-%d-%H-%M-%S)"
    # TODO: catch none 0 return value
    get_resp_to_tmp_files $api_token $channel $filepath_prefix

    # glue tmp files together.
    local output_filepath="$filepath_prefix.output.tmp"
    glue_tmp_files $channel $filepath_prefix $output_filepath

    echo $output_filepath
    return 0
}

# Query api, store with `filepath_prefix`
# eg:
#   filepath_prefix="./tmp/resp"
#   tmp files:
#   - ./tmp/resp.1.tmp
#   - ./tmp/resp.2.tmp
#   - ./tmp/resp.3.tmp
function get_resp_to_tmp_files() {
    local api_token="$1"
    local channel="$2"
    local filepath_prefix="$3"

    local i=1
    while :
    do
        if [[ -z "$next_cursor" ]]; then
            local data=$(join_arguments_www_form "token=$api_token" "channel=$channel" "$optional_arguments")
        else
            local data=$(join_arguments_www_form "token=$api_token" "channel=$channel" "cursor=$next_cursor" "$optional_arguments")
        fi

        resp=$(curl --silent -X POST -H "Authorization: Bearer $api_token" \
             -H "Content-type: application/x-www-form-urlencoded" \
             --data "$data"\
             https://slack.com/api/conversations.history)

        # if response is empty
        if [[ -z "$resp" ]]; then
            echo "ERROR: conversations.history on channel $channel response empty" 1>&2
            return 1
        fi

        # if not ok
        if ! $(echo $resp | jq '.ok'); then
            echo "ERROR: conversations.history on channel $channel not ok, response $resp" 1>&2
            return 1
        fi

        # allocate filename based on unique time stamp to tmp files
        local tmp_file_name="$filepath_prefix.$i.tmp"
        echo $resp | jq > $tmp_file_name

        # if no more data, break
        if ! $(echo $resp | jq '.has_more'); then
            break
        fi

        local next_cursor=$(echo $resp | jq '.response_metadata.next_cursor' | sed -e 's/^"//' -e 's/"$//')
        ((i++))
    done

    return 0
}


# Filter tmp files, glue them together in a natural sort order. 
#   (*Natural sort order* ref to `function ls_relative_path_natural_sort()`)
# Then merge them into a output file:
#   {
#     "channel": "$channel",
#     "messages": []
#   }
function glue_tmp_files() {
    local channel="$1"
    local filepath_prefix="$2"
    local output_filepath="$3"

    local tmp_dir=$(dirname "$filepath_prefix")
    local output_tmpfile="$3.tmp"

    echo "{ \"channel\": \"${channel}\", \"messages\": [] }" | jq > $output_filepath

    # filter only paths match given prefix
    for path in $(ls_relative_path_natural_sort ${tmp_dir} | grep ${filepath_prefix})
    do
        jq -s '{channel: .[0].channel, messages: (.[0].messages + .[1].messages) }' $output_filepath $path > $output_tmpfile
        cp $output_tmpfile $output_filepath
    done

    return 0
}


# ls tmp filename in a natural sort order
# Natural sort: (1, 2, ... , 11, 12...; not 1, 11, 2, 22, ...)
# Eg:
#   $ ls_relative_path_natural_sort ./tmp/
#   ./tmp/history_C019HHJ7KAQ.1.tmp
#   ./tmp/history_C019HHJ7KAQ.2.tmp
#   ./tmp/history_C0194KZD6P8.1.tmp
#   ./tmp/history_C0194KZD6P8.2.tmp
function ls_relative_path_natural_sort() {
    local directory="$1"

    for f in $(ls -v $directory)
    do
        echo $(join_path ${directory} ${f})
    done
    return 0
}
