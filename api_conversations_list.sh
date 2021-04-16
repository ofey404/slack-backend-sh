#!/usr/bin/bash
# Interacting with slack api.

source util.sh

# conversation.list
# https://api.slack.com/methods/conversations.list
function slack_conversations_list_wrapper() {
    local api_token="$1"
    local optional_arguments="${@:2}"

    local data=$(join_arguments_www_form "token=$api_token" "$optional_arguments")

    while :
    do
        resp=$(curl --silent -X POST -H "Authorization: Bearer $api_token" \
             -H "Content-type: application/x-www-form-urlencoded" \
             --data "$data"\
             https://slack.com/api/conversations.list)

        echo "$resp"
        # If no next cursor, break
        if [[ "\"\"" == `echo "$resp" | jq ".response_metadata.next_cursor"` ]]; then
            break
        fi

        # TODO
        echo "TODO: handle cursor" 1>&2
        exit 1
    done

    echo "$resp"
    return 0
}


