#!/usr/bin/env bash
IFS=$'\x1f' read -r model dir pct size cost ms add del effort five spend < <(jq -r '[
  .model.display_name // "?",
  .workspace.current_dir // .cwd // ".",
  (.context_window.used_percentage // 0 | floor),
  (.context_window.context_window_size // 0),
  (.cost.total_cost_usd // 0),
  (.cost.total_duration_ms // 0),
  (.cost.total_lines_added // 0),
  (.cost.total_lines_removed // 0),
  .effort.level // "",
  (.rate_limits.five_hour.used_percentage | if . then floor else "" end),
  (.rate_limits.spend_limit.used_percentage | if . then floor else "" end)
] | map(tostring) | join("\u001f")')

export GIT_OPTIONAL_LOCKS=0
branch=$(git -C "$dir" branch --show-current 2>/dev/null)
dirty=$(git -C "$dir" status --porcelain 2>/dev/null | head -1)

color() { (( $1 >= 80 )) && echo 31 || { (( $1 >= 60 )) && echo 33 || echo 32; }; }

filled=$(( pct / 10 )); bar=""
for i in {1..10}; do (( i <= filled )) && bar+="█" || bar+="░"; done
(( size >= 1000000 )) && sz="$(( size / 1000000 ))M" || sz="$(( size / 1000 ))k"

printf '\e[36m%s\e[0m' "$model"
[[ -n $effort ]] && printf '\e[2m %s\e[0m' "$effort"
printf ' \e[34m%s\e[0m' "${dir##*/}"
[[ -n $branch ]] && printf ' \e[35m %s%s\e[0m' "$branch" "${dirty:+*}"
printf ' \e[%sm%s %s%%\e[0m\e[2m/%s\e[0m' "$(color "$pct")" "$bar" "$pct" "$sz"
[[ -n $five ]] && printf ' \e[2m5h\e[0m \e[%sm%s%%\e[0m' "$(color "$five")" "$five"
[[ -n $spend ]] && printf ' \e[2mspend\e[0m \e[%sm%s%%\e[0m' "$(color "$spend")" "$spend"
printf ' \e[2m$%.2f %dm\e[0m \e[32m+%s\e[0m \e[31m-%s\e[0m\n' "$cost" "$(( ms / 60000 ))" "$add" "$del"
