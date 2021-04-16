#!/usr/bin/bash
# Some handy functions.

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


# If parameter is not found in `.env`,
# fallback to default value
function init_parameter() {
    local name="$1"
    local default_value="$2"

    if var=$(egrep "^$name=" .env); then
        var=${var#*=}
        echo "$var"
        return 0
    fi

    if [[ -z "$default_value" ]]; then
        echo "ERROR: Parameter $name not found in .env file, and default value is not provided." 1>&2
        exit 1
    fi

    echo "$default_value"
    return 0
}


function all_channel_id_from_list_file() {
    local list_file_path=$1
    for i in $(cat $list_file_path | jq '.channels[].id')
    do
        echo "$i" | sed -e 's/^"//' -e 's/"$//'
    done
    return 0
}

