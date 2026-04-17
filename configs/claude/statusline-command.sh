#!/bin/sh
# Claude Code status line - Pure/p10k style

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // .model.id')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Shorten home directory to ~
home="$HOME"
short_cwd=" $(echo "$cwd" | sed "s|^$home|~|")"

# Git branch with dirty indicator (grey, matching p10k VCS style)
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null | sed 's/^/@/')
  dirty=$(git -C "$cwd" status --porcelain 2>/dev/null | head -1)
  if [ -n "$dirty" ]; then
    git_info=" $branch*"
  else
    git_info=" $branch"
  fi
fi

# Return ANSI color code based on percentage:
#   <= 60 : green, 61-70 : yellow, >= 71 : red
pct_color() {
  pct_int="$1"
  if [ "$pct_int" -le 60 ]; then
    printf "\033[32m"   # green
  elif [ "$pct_int" -le 70 ]; then
    printf "\033[33m"   # yellow
  else
    printf "\033[31m"   # red
  fi
}

# Build a progress bar: filled blocks out of BAR_WIDTH total
# Usage: make_bar <percentage_float> <bar_width>
make_bar() {
  pct="$1"
  width="$2"
  filled=$(printf "%.0f" "$(echo "$pct $width" | awk '{printf "%f", $1 * $2 / 100}')")
  empty=$((width - filled))
  bar=""
  i=0
  while [ $i -lt $filled ]; do bar="${bar}█"; i=$((i+1)); done
  i=0
  while [ $i -lt $empty ];  do bar="${bar}░"; i=$((i+1)); done
  printf "%s" "$bar"
}

BAR_WIDTH=8
GREY=$(printf "\033[38;5;252m")
RESET=$(printf "\033[0m")

# Context usage bar + percentage (color based on usage)
ctx=""
if [ -n "$used" ]; then
  used_int=$(printf "%.0f" "$used")
  bar=$(make_bar "$used" "$BAR_WIDTH")
  color=$(pct_color "$used_int")
  ctx=" ctx: ${color}${bar} ${used_int}%${RESET}"
fi

# Rate limit bars + percentages (color based on usage)
rl=""
if [ -n "$five_pct" ]; then
  five_int=$(printf "%.0f" "$five_pct")
  bar5=$(make_bar "$five_pct" "$BAR_WIDTH")
  color5=$(pct_color "$five_int")
  rl="${rl} 5h: ${color5}${bar5} ${five_int}%${RESET}"
fi
if [ -n "$week_pct" ]; then
  week_int=$(printf "%.0f" "$week_pct")
  bar7=$(make_bar "$week_pct" "$BAR_WIDTH")
  color7=$(pct_color "$week_int")
  rl="${rl} 7d: ${color7}${bar7} ${week_int}%${RESET}"
fi

# Build 2-line status:
# Line 1: Git info / model / context usage / rate limits  (light grey)
# Line 2: Current directory  (blue)
printf "${GREY}%s  %s${RESET}%s%s\n\033[34m%s\033[0m" \
  "$git_info" \
  "$model" \
  "$ctx" \
  "$rl" \
  "$short_cwd"
