#!/bin/bash
# Spustí Pomocníka WoWpoČesku pro Mac v okně Terminálu (dvojklik ve Finderu).
cd "$(dirname "$0")" || exit 1
DIR="$(pwd)"
printf '\033]0;WoWpoČesku – Pomocník\007'
osascript -l JavaScript "$DIR/pomocnik-mac.js" "$DIR" "$@"
echo
read -n 1 -s -r -p "Pomocník skončil. Stiskni libovolnou klávesu pro zavření okna…"
