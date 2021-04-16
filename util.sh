#!/usr/bin/bash
# Some handy functions.

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


