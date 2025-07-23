#!/bin/bash

channel_id="$1"

CHANNEL_URL="https://www.youtube.com/channel/$channel_id"

yt-dlp --skip-download \
  --write-auto-subs \
  --sub-langs '.*orig' \
  --sub-format srt \
  --output "transcripts/$channel_id/%(id)s.%(ext)s" \
  "$CHANNEL_URL"
