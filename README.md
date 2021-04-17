# Slack Message Backup Backend with bash

> 可恶，不要小看了 yaml 工程师啊！

A quick and dirty method to backup slack messages. Mainly written by bash.

## Usage

run `main.sh`, data would be stored on [./data](./data) directory.

Get variables from `.env` file. Example of `.env` file in in [.env.example](./.env.example), you should create your `.env` by yourself.

```bash
$ echo "API_TOKEN=xoxb-YOUR-API-TOKEN" > .env
```

Then we can run the main script.
```bash
$ ./main.sh 
# get history of id C01FS2C1SKC, channel sig-graphics
# get history of id C01PZ5R7NGN, channel sig-machine-learning
# ...
# get history of id C019HHJ7KAQ, channel random

$ ls data/
# conversation_history_C0194KZD6P8.json
# conversation_history_C019HHJ7KAQ.json
# ...
# conversation_history_C01BV5JJQF7.json
```


## Dependency

- `curl`
- `jq`

