#!/bin/sh

read file time <<< $(awk -v kw="$1" '/-->/ {ts=$1} $0 ~ kw {print FILENAME, ts; exit}' ./transcripts/**)

filename=$(basename "$file")
video_id="${filename%.en.srt}"
IFS=':,'
read -r hh mm ss ms <<< "$time"
seconds=$((10#$hh * 3600 + 10#$mm * 60 + 10#$ss))

start=$seconds
end=$((seconds+10))

url="https://www.youtube.com/watch?v=$video_id&t=$start"

echo "$url"


