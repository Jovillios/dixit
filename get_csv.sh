#!/bin/bash
echo "id,title,url,transcript" >videos.csv

for f in transcripts/*.srt; do
  # Extract the filename without path and extension
  filename=$(basename "$f")      # e.g., abc123.en.srt
  video_id="${filename%.en.srt}" # remove the .en.srt suffix

  title=$(yt-dlp --get-title "https://www.youtube.com/watch?v=$video_id")
  url="https://www.youtube.com/watch?v=$video_id"
  transcript=$(grep -vE '^[0-9]+$|-->|^$' "$f" | tr '\n' ' ' | sed 's/"/""/g')

  echo "\"$video_id\",\"$title\",\"$url\",\"$transcript\"" >>videos.csv
done
