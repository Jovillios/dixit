#!/bin/bash

channel_id=$(bash search_channel_id.sh "$2")

if [ ! -d "./transcripts/$channel_id" ]; then
  mkdir "./transcripts/$channel_id"
  bash get_transcripts_channel.sh "$channel_id"
fi

read file time <<<$(awk -v kw="$1" '/-->/ {ts=$1} $0 ~ kw {print FILENAME, ts; exit}' ./transcripts/$channel_id/**)

filename=$(basename "$file")
video_id="${filename%.*.srt}"
IFS=':,'
read -r hh mm ss ms <<<"$time"
seconds=$((10#$hh * 3600 + 10#$mm * 60 + 10#$ss))

start=$seconds
end=$((seconds + 10))

url="https://www.youtube.com/watch?v=$video_id&t=$start"

echo "$url"
