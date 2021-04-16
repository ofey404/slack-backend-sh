#!/usr/bin/bash
# Interacting with slack api.

source util.sh

# users.list
# https://api.slack.com/methods/users.list

function slack_users_list_wrapper() {
    local api_token="$1"
    local optional_arguments="${@:2}"

    local data=$(join_arguments_www_form "token=$api_token" "$optional_arguments")

    while :
    do
        resp=$(curl --silent -X GET -H "Authorization: Bearer $api_token" \
             -H "Content-type: application/x-www-form-urlencoded" \
             --data "$data"\
             https://slack.com/api/users.list)

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

# Extract user info needed by jq. Just a demo.
# Change patterns inside if more information is wanted.
function extract_users_info_from_users_file() {
    local users_file_path="$1"
    cat $users_file_path | jq '.members[] | {id: .id, display_name: .profile.display_name}'
}

