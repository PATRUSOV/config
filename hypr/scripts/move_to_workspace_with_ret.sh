#!/bin/bash

PREV_WS_FILE="/tmp/hypr_prev_ws"

if [ -z "$1" ]; then
    echo "Usage: $0 <workspace_name>"
    exit 1
fi

target="$1"
current=$(hyprctl activeworkspace -j | jq -r ".name")
prev=$(cat "$PREV_WS_FILE" 2>/dev/null)

if [ "$current" = "$target" ]; then
    if [ -n "$prev" ] && [ "$prev" != "$target" ]; then
        hyprctl dispatch workspace "name:$prev"
        rm "$PREV_WS_FILE"
    fi
else
    echo "$current" >"$PREV_WS_FILE"
    hyprctl dispatch workspace "name:$target"
fi
