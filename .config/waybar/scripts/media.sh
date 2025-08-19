#!/bin/bash

# Check if playerctl is installed
if ! command -v playerctl &> /dev/null; then
    echo "{\"text\": \"playerctl not installed\", \"class\": \"error\"}"
    exit 1
fi

# Check if Spotify is running
if ! playerctl -l 2>/dev/null | grep -q spotify; then
    echo "{\"text\": \"\", \"class\": \"inactive\"}"
    exit 0
fi

# Get player status
status=$(playerctl -p spotify status 2>/dev/null)
if [ "$status" = "Paused" ]; then
    echo "{\"text\": \"Paused\", \"class\": \"paused\"}"
    exit 0
fi

# Get artist and title
artist=$(playerctl -p spotify metadata artist 2>/dev/null)
title=$(playerctl -p spotify metadata title 2>/dev/null)

# Format output for Waybar
if [ -n "$artist" ] && [ -n "$title" ]; then
    echo "{\"text\": \"$artist - $title\", \"class\": \"playing\"}"
else
    echo "{\"text\": \"\", \"class\": \"inactive\"}"
fi