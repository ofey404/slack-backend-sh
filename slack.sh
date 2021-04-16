#!/usr/bin/bash
# Interacting with slack api.

function join_arguments_www_form() {
    local arguments="$@"
    local ans=""

    for arg in $arguments
    do
        if [[ -z "$ans" ]]; then
            ans="$arg"
        else
            ans="$ans&$arg"
        fi
    done

    echo $ans
    return 0
}


function slack_conversation_list_wrapper() {
    local api_token="$1"
    local optional_arguments="${@:2}"

    local data=$(join_arguments_www_form "token=$API_TOKEN" "$optional_arguments")

    while :
    do
        resp=$(curl -X POST -H "Authorization: Bearer $api_token" \
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
