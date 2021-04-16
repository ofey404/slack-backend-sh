#!/usr/bin/bash

source assert.sh
source slack.sh

VERBOSE=false
# VERBOSE=true

assert "join_arguments_www_form test1=1 test2=2" "test1=1&test2=2"
assert "join_arguments_www_form" ""
assert "all_channel_id_from_list_file test_data/list.json" "C0194KZD6P8
C019HHJ7KAQ
C01ARFXJ2EL
C01BAUKNZ9S
C01BHNM7K4Z
C01BV5JJQF7
C01CLF5BENL
C01DPAVKWCU
C01DQ1TEAAC
C01E6B4E0SG
C01FPFF1CUU
C01FS2C1SKC
C01FU5GKBAT
C01G5NRSS8M
C01K9UJTW3H
C01LWMRMKV4
C01M9DUQ6UA
C01PZ5R7NGN
C01R3GPP8F3
C01RS5WFUCE
C01U1761PP0
C0194KZD6P8
C019HHJ7KAQ
C01ARFXJ2EL
C01BAUKNZ9S
C01BHNM7K4Z
C01BV5JJQF7
C01CLF5BENL
C01DPAVKWCU
C01DQ1TEAAC
C01E6B4E0SG
C01FPFF1CUU
C01FS2C1SKC
C01FU5GKBAT
C01G5NRSS8M
C01K9UJTW3H
C01LWMRMKV4
C01M9DUQ6UA
C01PZ5R7NGN
C01R3GPP8F3
C01RS5WFUCE
C01U1761PP0"

assert_end slack_test


if $VERBOSE
then
    source util.sh
    API_TOKEN=$(init_parameter API_TOKEN)

    echo $(slack_conversation_list_wrapper $API_TOKEN | jq)
    echo $(slack_conversation_list_wrapper $API_TOKEN "limit=1" | jq)
fi

