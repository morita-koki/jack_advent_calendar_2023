#!/bin/bash

SLACK_WEBHOOK_URL="取得したWEBHOOK URL"

tmp_json=$(curl -Ls https://news.yahoo.co.jp/categories/it \
        | $HOME/go/bin/pup 'section#uamods-topics > div > div > div > ul > li > a json{}')


titles_raw=$(echo $tmp_json | jq ".[].text")
links_raw=$(echo $tmp_json | jq ".[].href")

news=""
while IFS= read -r title && IFS= read -r link; do
    tmp="- <$link|$title>\n"
    # echo $tmp
    news="$news$tmp"
done < <(paste -d "\n" \
            <(echo $titles_raw | grep -o '"[^"]*"' | sed 's/"//g') \
            <(echo $links_raw  | grep -o '"[^"]*"' | sed 's/"//g'))

POST_DATA=$(cat << EOS
{
    "text": "今日のITニュース\n$news"
}
EOS
)

curl -X POST -H 'Content-type: application/json' \
        --data "$POST_DATA" "$SLACK_WEBHOOK_URL"
