#!/usr/bin/env bash
input=$(cat)
IFS=$'\t' read -r model dir pct size cost ms add del < <(jq -r '[
  .model.display_name // "?",
  .workspace.current_dir // .cwd // ".",
  (.context_window.used_percentage // 0 | floor),
  (.context_window.context_window_size // 0),
  (.cost.total_cost_usd // 0),
  (.cost.total_duration_ms // 0),
  (.cost.total_lines_added // 0),
  (.cost.total_lines_removed // 0)
] | @tsv' <<<"$input")

branch=$(git -C "$dir" branch --show-current 2>/dev/null)
dirty=$(git -C "$dir" status --porcelain 2>/dev/null | head -1)

if   (( pct >= 80 )); then c=31
elif (( pct >= 60 )); then c=33
else c=32; fi
filled=$(( pct / 10 )); bar=""
for i in {1..10}; do (( i <= filled )) && bar+="█" || bar+="░"; done

mins=$(( ms / 60000 ))
printf '\e[36m%s\e[0m' "$model"
printf ' \e[34m%s\e[0m' "${dir##*/}"
[[ -n $branch ]] && printf ' \e[35m %s%s\e[0m' "$branch" "${dirty:+*}"
printf ' \e[%sm%s %s%%\e[0m\e[2m/%sk\e[0m' "$c" "$bar" "$pct" "$(( size / 1000 ))"
printf ' \e[2m$%.2f %dm\e[0m \e[32m+%s\e[0m \e[31m-%s\e[0m\n' "$cost" "$mins" "$add" "$del"
