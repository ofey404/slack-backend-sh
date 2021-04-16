#!/usr/bin/bash

source assert.sh
source slack.sh

VERBOSE=false
# VERBOSE=true

# conversation.list
# https://api.slack.com/methods/conversations.list
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

# users.list
# https://api.slack.com/methods/users.list
assert "extract_users_info_from_users_file test_data/users.json" '{
  "id": "USLACKBOT",
  "display_name": "Slackbot"
}
{
  "id": "U018WKP8CJK",
  "display_name": "罗翔 17cs"
}
{
  "id": "U018WN50ML7",
  "display_name": ""
}
{
  "id": "U0194L0FW5U",
  "display_name": "杨俊逸 16cs"
}
{
  "id": "U019BC1VCM8",
  "display_name": "胡志峰 16cs"
}
{
  "id": "U019BJ60Q2X",
  "display_name": "李洪嵚 17cs"
}
{
  "id": "U019T22A1JN",
  "display_name": "马逸君 (17CS)"
}
{
  "id": "U019T84PQGK",
  "display_name": "谭一凡 18cs"
}
{
  "id": "U01A611AJ81",
  "display_name": "riteme"
}
{
  "id": "U01B22SKPFX",
  "display_name": "谢子飏 19 CS"
}
{
  "id": "U01B4UX4K8T",
  "display_name": "向钟云博 17cs"
}
{
  "id": "U01B6P2EWRL",
  "display_name": "XuYipei"
}
{
  "id": "U01BARL28RY",
  "display_name": "HatsuneHan"
}
{
  "id": "U01BDC8RRMG",
  "display_name": ""
}
{
  "id": "U01BDHY4TU3",
  "display_name": "Weichen Li"
}
{
  "id": "U01BFLBMS2X",
  "display_name": "陈泓宜 (Hakula) 18cs"
}
{
  "id": "U01BH2FFKB5",
  "display_name": "赵文轩"
}
{
  "id": "U01BKHW1V7E",
  "display_name": "Pryest-18-CS"
}
{
  "id": "U01BPUMPH7G",
  "display_name": "pyw"
}
{
  "id": "U01BQ651M7Y",
  "display_name": ""
}
{
  "id": "U01BTJNNFC5",
  "display_name": "Yardang"
}
{
  "id": "U01BU8HU22Z",
  "display_name": "廉正"
}
{
  "id": "U01BUUXU524",
  "display_name": "李叔禄"
}
{
  "id": "U01BV371P0X",
  "display_name": "黄韵澄 18cs"
}
{
  "id": "U01BWLXJJF4",
  "display_name": ""
}
{
  "id": "U01C37VFWKA",
  "display_name": "Fanqi Yu"
}
{
  "id": "U01C60CQD0E",
  "display_name": "XingtongWang"
}
{
  "id": "U01C7CH4K7Z",
  "display_name": "王少文 19 CS"
}
{
  "id": "U01C9KLFJUV",
  "display_name": "Joseph Xie"
}
{
  "id": "U01C9SUVAHG",
  "display_name": "wangbo"
}
{
  "id": "U01CG00FJEQ",
  "display_name": "Yxuan"
}
{
  "id": "U01CK0C6FE0",
  "display_name": "gkzhb"
}
{
  "id": "U01CLGAGRMW",
  "display_name": "孔令高"
}
{
  "id": "U01CQ59KL05",
  "display_name": ""
}
{
  "id": "U01D01M9PAN",
  "display_name": "AsssassinTB"
}
{
  "id": "U01D2DSJ7EC",
  "display_name": "Runjie Jin"
}
{
  "id": "U01D4V2UV3M",
  "display_name": "Bing Xue"
}
{
  "id": "U01DC4FS83S",
  "display_name": "Calvin Cui"
}
{
  "id": "U01DC5VTQLQ",
  "display_name": "杜雨轩19cs"
}
{
  "id": "U01DHQM4YKS",
  "display_name": "Rui Wang"
}
{
  "id": "U01DT3J2ALQ",
  "display_name": "zeroslope"
}
{
  "id": "U01E44C8273",
  "display_name": "tengxm"
}
{
  "id": "U01F4QP7D6D",
  "display_name": "ZihangLin"
}
{
  "id": "U01F73964V6",
  "display_name": "陈巍文 17 物理"
}
{
  "id": "U01G3CW27SR",
  "display_name": "Jingrong Chen"
}
{
  "id": "U01G663G3J9",
  "display_name": "Joe（刘孙瑞 16cs）"
}
{
  "id": "U01G664F28M",
  "display_name": ""
}
{
  "id": "U01G9ERJRA7",
  "display_name": "Shawn Jin"
}
{
  "id": "U01GG125Y7R",
  "display_name": "Maltose"
}
{
  "id": "U01HLT5V196",
  "display_name": "shenggo"
}
{
  "id": "U01HUFRMUMS",
  "display_name": "Gootter H"
}
{
  "id": "U01JQS951JP",
  "display_name": "G0"
}
{
  "id": "U01K9EASXPH",
  "display_name": ""
}
{
  "id": "U01KALA83DM",
  "display_name": ""
}
{
  "id": "U01KALAHJ0P",
  "display_name": "Simon Nie 17cs"
}
{
  "id": "U01KD418Y9W",
  "display_name": "张作柏 17cs"
}
{
  "id": "U01KHAZDUQN",
  "display_name": "Yongyi Yang"
}
{
  "id": "U01KJL7D3D4",
  "display_name": ""
}
{
  "id": "U01KJL7NE6S",
  "display_name": "19 CyberSecurity_WeiZiQi"
}
{
  "id": "U01KLTDG64D",
  "display_name": "程鹏志 19cs"
}
{
  "id": "U01KMEQHVU5",
  "display_name": "唐思源 19CS"
}
{
  "id": "U01KNB327CM",
  "display_name": "郑钦元 17CS"
}
{
  "id": "U01KNB3BKEH",
  "display_name": "杨森 19cs"
}
{
  "id": "U01KNB3LM0D",
  "display_name": "zmx"
}
{
  "id": "U01KNM649B7",
  "display_name": "Nole Lee"
}
{
  "id": "U01KQ40FD99",
  "display_name": "苏津岳"
}
{
  "id": "U01KQ84FX4K",
  "display_name": "孙若诗 19cs"
}
{
  "id": "U01KQD64PLK",
  "display_name": "Ruming Tang 18DS"
}
{
  "id": "U01KRDMQ9KL",
  "display_name": ""
}
{
  "id": "U01KRDN40EN",
  "display_name": "常朝坤 16cs"
}
{
  "id": "U01KRKPFQCB",
  "display_name": ""
}
{
  "id": "U01KRKPQXRR",
  "display_name": ""
}
{
  "id": "U01KRQS3ND8",
  "display_name": "ztx97"
}
{
  "id": "U01KS3169CK",
  "display_name": "杨凯茜 17 CS"
}
{
  "id": "U01KWBQAPV0",
  "display_name": "yunhui li"
}
{
  "id": "U01KXG6SH61",
  "display_name": "stig"
}
{
  "id": "U01KXJGL10C",
  "display_name": ""
}
{
  "id": "U01KXJGV2JY",
  "display_name": "George Xiong"
}
{
  "id": "U01KXJH91U4",
  "display_name": "Yining Zheng 15cs"
}
{
  "id": "U01L0SS1U79",
  "display_name": "Yang Liu 13se"
}
{
  "id": "U01L42QJT4H",
  "display_name": "杨远琨 18ds"
}
{
  "id": "U01L42QTVND",
  "display_name": ""
}
{
  "id": "U01L7MWKS78",
  "display_name": "Tianyu Pan"
}
{
  "id": "U01LAB2FX1Q",
  "display_name": "周博修 19 核"
}
{
  "id": "U01LB6Y4NPP",
  "display_name": "Chuanzi He"
}
{
  "id": "U01LC075X28",
  "display_name": "liucheese"
}
{
  "id": "U01LF8ZU9FA",
  "display_name": ""
}
{
  "id": "U01LF900J72",
  "display_name": "Edward Chu 13CS"
}
{
  "id": "U01LF901VQ8",
  "display_name": "朱凌枫"
}
{
  "id": "U01LF90AVL0",
  "display_name": "7890 6"
}
{
  "id": "U01LF90L8P2",
  "display_name": "孟博宇 17 DS"
}
{
  "id": "U01LF9GNT24",
  "display_name": "Shanqing Lin"
}
{
  "id": "U01LLTLR9MJ",
  "display_name": "聂绍珩 19 CS"
}
{
  "id": "U01LPR47XQR",
  "display_name": "Jialin Cao"
}
{
  "id": "U01M1B7V5EW",
  "display_name": ""
}
{
  "id": "U01M69AUK0V",
  "display_name": "张斐然"
}
{
  "id": "U01M82F9K8A",
  "display_name": "符景超 16物理"
}
{
  "id": "U01M9BV1B3L",
  "display_name": "Gu"
}
{
  "id": "U01NK1PJSS3",
  "display_name": "bingo cai"
}
{
  "id": "U01NWJEQ5U1",
  "display_name": "George Dong"
}
{
  "id": "U01P9QDAK4P",
  "display_name": "Gin"
}
{
  "id": "U01PH1ZCV70",
  "display_name": ""
}
{
  "id": "U01PLFRBF7Y",
  "display_name": "Calvin Cui"
}
{
  "id": "U01PNT8CX4K",
  "display_name": "徐畅 19 CS"
}
{
  "id": "U01PNTSMRS7",
  "display_name": "戴旭书 19 CS"
}
{
  "id": "U01PNURP3CJ",
  "display_name": "陈璟璨 19 CS"
}
{
  "id": "U01PPU1K0V9",
  "display_name": "祁昊 19 CS"
}
{
  "id": "U01PVBHV60K",
  "display_name": "邱晓文 19 CS"
}
{
  "id": "U01Q0KH8EDA",
  "display_name": "19 CS 曹丝露"
}
{
  "id": "U01Q1AW0VQR",
  "display_name": "ChenLida"
}
{
  "id": "U01Q1UFCQFK",
  "display_name": "Kieray"
}
{
  "id": "U01Q2PH5VK8",
  "display_name": "Mirack_CTY"
}
{
  "id": "U01QAJPHQDQ",
  "display_name": "叶鑫茹"
}
{
  "id": "U01QF696BDY",
  "display_name": "杜安龙 19CS"
}
{
  "id": "U01QHE1NJ3S",
  "display_name": "Duanzhuohao"
}
{
  "id": "U01QQLZFVQQ",
  "display_name": "Renatus"
}
{
  "id": "U01QX0S8W6P",
  "display_name": "蔡栋梁 18cs"
}
{
  "id": "U01QXR6CA0L",
  "display_name": "刘煜 20保密"
}
{
  "id": "U01QYHK73EX",
  "display_name": "邓勇军 18 cs"
}
{
  "id": "U01R99LKP8D",
  "display_name": "徐心茗"
}
{
  "id": "U01RFHL5R40",
  "display_name": "周子博"
}
{
  "id": "U01RFM0F9T2",
  "display_name": "李睿潇 20技科"
}
{
  "id": "U01RFSQ1MHU",
  "display_name": ""
}
{
  "id": "U01RX6WMASZ",
  "display_name": "Asafarr"
}
{
  "id": "U01S251HUBF",
  "display_name": "W. J."
}
{
  "id": "U01S51JHGQL",
  "display_name": ""
}
{
  "id": "U01S86XEC07",
  "display_name": ""
}
{
  "id": "U01SCEP97DW",
  "display_name": "Ye Cao"
}
{
  "id": "U01SPACGAAE",
  "display_name": "彭劲搏"
}
{
  "id": "U01SQKS0XFZ",
  "display_name": "YANG-CHEN"
}
{
  "id": "U01SQQHKP0V",
  "display_name": "苟嘉杰 19cs"
}
{
  "id": "U01SV4SQFU4",
  "display_name": ""
}
{
  "id": "U01SYEF6JEA",
  "display_name": "Ray"
}
{
  "id": "U01TAG96CRZ",
  "display_name": ""
}
{
  "id": "U01TZBL3PH6",
  "display_name": ""
}
{
  "id": "U01U8ADQHJP",
  "display_name": "Youzhe Liu 18 DS"
}
{
  "id": "USLACKBOT",
  "display_name": "Slackbot"
}
{
  "id": "U018WKP8CJK",
  "display_name": "罗翔 17cs"
}
{
  "id": "U018WN50ML7",
  "display_name": ""
}
{
  "id": "U0194L0FW5U",
  "display_name": "杨俊逸 16cs"
}
{
  "id": "U019BC1VCM8",
  "display_name": "胡志峰 16cs"
}
{
  "id": "U019BJ60Q2X",
  "display_name": "李洪嵚 17cs"
}
{
  "id": "U019T22A1JN",
  "display_name": "马逸君 (17CS)"
}
{
  "id": "U019T84PQGK",
  "display_name": "谭一凡 18cs"
}
{
  "id": "U01A611AJ81",
  "display_name": "riteme"
}
{
  "id": "U01B22SKPFX",
  "display_name": "谢子飏 19 CS"
}
{
  "id": "U01B4UX4K8T",
  "display_name": "向钟云博 17cs"
}
{
  "id": "U01B6P2EWRL",
  "display_name": "XuYipei"
}
{
  "id": "U01BARL28RY",
  "display_name": "HatsuneHan"
}
{
  "id": "U01BDC8RRMG",
  "display_name": ""
}
{
  "id": "U01BDHY4TU3",
  "display_name": "Weichen Li"
}
{
  "id": "U01BFLBMS2X",
  "display_name": "陈泓宜 (Hakula) 18cs"
}
{
  "id": "U01BH2FFKB5",
  "display_name": "赵文轩"
}
{
  "id": "U01BKHW1V7E",
  "display_name": "Pryest-18-CS"
}
{
  "id": "U01BPUMPH7G",
  "display_name": "pyw"
}
{
  "id": "U01BQ651M7Y",
  "display_name": ""
}
{
  "id": "U01BTJNNFC5",
  "display_name": "Yardang"
}
{
  "id": "U01BU8HU22Z",
  "display_name": "廉正"
}
{
  "id": "U01BUUXU524",
  "display_name": "李叔禄"
}
{
  "id": "U01BV371P0X",
  "display_name": "黄韵澄 18cs"
}
{
  "id": "U01BWLXJJF4",
  "display_name": ""
}
{
  "id": "U01C37VFWKA",
  "display_name": "Fanqi Yu"
}
{
  "id": "U01C60CQD0E",
  "display_name": "XingtongWang"
}
{
  "id": "U01C7CH4K7Z",
  "display_name": "王少文 19 CS"
}
{
  "id": "U01C9KLFJUV",
  "display_name": "Joseph Xie"
}
{
  "id": "U01C9SUVAHG",
  "display_name": "wangbo"
}
{
  "id": "U01CG00FJEQ",
  "display_name": "Yxuan"
}
{
  "id": "U01CK0C6FE0",
  "display_name": "gkzhb"
}
{
  "id": "U01CLGAGRMW",
  "display_name": "孔令高"
}
{
  "id": "U01CQ59KL05",
  "display_name": ""
}
{
  "id": "U01D01M9PAN",
  "display_name": "AsssassinTB"
}
{
  "id": "U01D2DSJ7EC",
  "display_name": "Runjie Jin"
}
{
  "id": "U01D4V2UV3M",
  "display_name": "Bing Xue"
}
{
  "id": "U01DC4FS83S",
  "display_name": "Calvin Cui"
}
{
  "id": "U01DC5VTQLQ",
  "display_name": "杜雨轩19cs"
}
{
  "id": "U01DHQM4YKS",
  "display_name": "Rui Wang"
}
{
  "id": "U01DT3J2ALQ",
  "display_name": "zeroslope"
}
{
  "id": "U01E44C8273",
  "display_name": "tengxm"
}
{
  "id": "U01F4QP7D6D",
  "display_name": "ZihangLin"
}
{
  "id": "U01F73964V6",
  "display_name": "陈巍文 17 物理"
}
{
  "id": "U01G3CW27SR",
  "display_name": "Jingrong Chen"
}
{
  "id": "U01G663G3J9",
  "display_name": "Joe（刘孙瑞 16cs）"
}
{
  "id": "U01G664F28M",
  "display_name": ""
}
{
  "id": "U01G9ERJRA7",
  "display_name": "Shawn Jin"
}
{
  "id": "U01GG125Y7R",
  "display_name": "Maltose"
}
{
  "id": "U01HLT5V196",
  "display_name": "shenggo"
}
{
  "id": "U01HUFRMUMS",
  "display_name": "Gootter H"
}
{
  "id": "U01JQS951JP",
  "display_name": "G0"
}
{
  "id": "U01K9EASXPH",
  "display_name": ""
}
{
  "id": "U01KALA83DM",
  "display_name": ""
}
{
  "id": "U01KALAHJ0P",
  "display_name": "Simon Nie 17cs"
}
{
  "id": "U01KD418Y9W",
  "display_name": "张作柏 17cs"
}
{
  "id": "U01KHAZDUQN",
  "display_name": "Yongyi Yang"
}
{
  "id": "U01KJL7D3D4",
  "display_name": ""
}
{
  "id": "U01KJL7NE6S",
  "display_name": "19 CyberSecurity_WeiZiQi"
}
{
  "id": "U01KLTDG64D",
  "display_name": "程鹏志 19cs"
}
{
  "id": "U01KMEQHVU5",
  "display_name": "唐思源 19CS"
}
{
  "id": "U01KNB327CM",
  "display_name": "郑钦元 17CS"
}
{
  "id": "U01KNB3BKEH",
  "display_name": "杨森 19cs"
}
{
  "id": "U01KNB3LM0D",
  "display_name": "zmx"
}
{
  "id": "U01KNM649B7",
  "display_name": "Nole Lee"
}
{
  "id": "U01KQ40FD99",
  "display_name": "苏津岳"
}
{
  "id": "U01KQ84FX4K",
  "display_name": "孙若诗 19cs"
}
{
  "id": "U01KQD64PLK",
  "display_name": "Ruming Tang 18DS"
}
{
  "id": "U01KRDMQ9KL",
  "display_name": ""
}
{
  "id": "U01KRDN40EN",
  "display_name": "常朝坤 16cs"
}
{
  "id": "U01KRKPFQCB",
  "display_name": ""
}
{
  "id": "U01KRKPQXRR",
  "display_name": ""
}
{
  "id": "U01KRQS3ND8",
  "display_name": "ztx97"
}
{
  "id": "U01KS3169CK",
  "display_name": "杨凯茜 17 CS"
}
{
  "id": "U01KWBQAPV0",
  "display_name": "yunhui li"
}
{
  "id": "U01KXG6SH61",
  "display_name": "stig"
}
{
  "id": "U01KXJGL10C",
  "display_name": ""
}
{
  "id": "U01KXJGV2JY",
  "display_name": "George Xiong"
}
{
  "id": "U01KXJH91U4",
  "display_name": "Yining Zheng 15cs"
}
{
  "id": "U01L0SS1U79",
  "display_name": "Yang Liu 13se"
}
{
  "id": "U01L42QJT4H",
  "display_name": "杨远琨 18ds"
}
{
  "id": "U01L42QTVND",
  "display_name": ""
}
{
  "id": "U01L7MWKS78",
  "display_name": "Tianyu Pan"
}
{
  "id": "U01LAB2FX1Q",
  "display_name": "周博修 19 核"
}
{
  "id": "U01LB6Y4NPP",
  "display_name": "Chuanzi He"
}
{
  "id": "U01LC075X28",
  "display_name": "liucheese"
}
{
  "id": "U01LF8ZU9FA",
  "display_name": ""
}
{
  "id": "U01LF900J72",
  "display_name": "Edward Chu 13CS"
}
{
  "id": "U01LF901VQ8",
  "display_name": "朱凌枫"
}
{
  "id": "U01LF90AVL0",
  "display_name": "7890 6"
}
{
  "id": "U01LF90L8P2",
  "display_name": "孟博宇 17 DS"
}
{
  "id": "U01LF9GNT24",
  "display_name": "Shanqing Lin"
}
{
  "id": "U01LLTLR9MJ",
  "display_name": "聂绍珩 19 CS"
}
{
  "id": "U01LPR47XQR",
  "display_name": "Jialin Cao"
}
{
  "id": "U01M1B7V5EW",
  "display_name": ""
}
{
  "id": "U01M69AUK0V",
  "display_name": "张斐然"
}
{
  "id": "U01M82F9K8A",
  "display_name": "符景超 16物理"
}
{
  "id": "U01M9BV1B3L",
  "display_name": "Gu"
}
{
  "id": "U01NK1PJSS3",
  "display_name": "bingo cai"
}
{
  "id": "U01NWJEQ5U1",
  "display_name": "George Dong"
}
{
  "id": "U01P9QDAK4P",
  "display_name": "Gin"
}
{
  "id": "U01PH1ZCV70",
  "display_name": ""
}
{
  "id": "U01PLFRBF7Y",
  "display_name": "Calvin Cui"
}
{
  "id": "U01PNT8CX4K",
  "display_name": "徐畅 19 CS"
}
{
  "id": "U01PNTSMRS7",
  "display_name": "戴旭书 19 CS"
}
{
  "id": "U01PNURP3CJ",
  "display_name": "陈璟璨 19 CS"
}
{
  "id": "U01PPU1K0V9",
  "display_name": "祁昊 19 CS"
}
{
  "id": "U01PVBHV60K",
  "display_name": "邱晓文 19 CS"
}
{
  "id": "U01Q0KH8EDA",
  "display_name": "19 CS 曹丝露"
}
{
  "id": "U01Q1AW0VQR",
  "display_name": "ChenLida"
}
{
  "id": "U01Q1UFCQFK",
  "display_name": "Kieray"
}
{
  "id": "U01Q2PH5VK8",
  "display_name": "Mirack_CTY"
}
{
  "id": "U01QAJPHQDQ",
  "display_name": "叶鑫茹"
}
{
  "id": "U01QF696BDY",
  "display_name": "杜安龙 19CS"
}
{
  "id": "U01QHE1NJ3S",
  "display_name": "Duanzhuohao"
}
{
  "id": "U01QQLZFVQQ",
  "display_name": "Renatus"
}
{
  "id": "U01QX0S8W6P",
  "display_name": "蔡栋梁 18cs"
}
{
  "id": "U01QXR6CA0L",
  "display_name": "刘煜 20保密"
}
{
  "id": "U01QYHK73EX",
  "display_name": "邓勇军 18 cs"
}
{
  "id": "U01R99LKP8D",
  "display_name": "徐心茗"
}
{
  "id": "U01RFHL5R40",
  "display_name": "周子博"
}
{
  "id": "U01RFM0F9T2",
  "display_name": "李睿潇 20技科"
}
{
  "id": "U01RFSQ1MHU",
  "display_name": ""
}
{
  "id": "U01RX6WMASZ",
  "display_name": "Asafarr"
}
{
  "id": "U01S251HUBF",
  "display_name": "W. J."
}
{
  "id": "U01S51JHGQL",
  "display_name": ""
}
{
  "id": "U01S86XEC07",
  "display_name": ""
}
{
  "id": "U01SCEP97DW",
  "display_name": "Ye Cao"
}
{
  "id": "U01SPACGAAE",
  "display_name": "彭劲搏"
}
{
  "id": "U01SQKS0XFZ",
  "display_name": "YANG-CHEN"
}
{
  "id": "U01SQQHKP0V",
  "display_name": "苟嘉杰 19cs"
}
{
  "id": "U01SV4SQFU4",
  "display_name": ""
}
{
  "id": "U01SYEF6JEA",
  "display_name": "Ray"
}
{
  "id": "U01TAG96CRZ",
  "display_name": ""
}
{
  "id": "U01TZBL3PH6",
  "display_name": ""
}
{
  "id": "U01U8ADQHJP",
  "display_name": "Youzhe Liu 18 DS"
}
'

assert_end slack_test

if $VERBOSE
then
    source util.sh
    API_TOKEN=$(init_parameter API_TOKEN)

    echo $(slack_conversations_list_wrapper $API_TOKEN | jq)
    echo $(slack_conversations_list_wrapper $API_TOKEN "limit=1" | jq)
fi

