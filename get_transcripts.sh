#!/bin/bash

CHANNEL_URL="$1"

yt-dlp --skip-download \
  --write-auto-subs \
  --sub-lang en \
  --sub-format srt \
  --output "transcripts/%(channel)s/%(id)s.%(ext)s" \
  "$CHANNEL_URL"
