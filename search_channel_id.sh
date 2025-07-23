#!/bin/bash

res=$(awk -v kw="$1:" -F ':' 'tolower($0) ~ tolower(kw) {print $2}' ./fast_channel_id_search.txt)
if [ "$res" ]; then
  echo "$res"
else
  res=$(yt-dlp ytsearch:"$1" --skip-download --print "%(channel_id)s")
  echo "$1:$res" >>./fast_channel_id_search.txt
  echo "$res"
fi
