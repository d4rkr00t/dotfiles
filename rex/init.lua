rex.bind("cmd+=", "pane.resize", { direction = "right", amount = 1 })
rex.bind("cmd+-", "pane.resize", { direction = "left", amount = 1 })
rex.bind("cmd+shift+=", "pane.resize", { direction = "down", amount = 1 })
rex.bind("cmd+shift+-", "pane.resize", { direction = "up", amount = 1 })

rex.bind("cmd+alt+=", "client.font.increase")
rex.bind("cmd+alt+-", "client.font.decrease")
rex.bind("cmd+alt+0", "client.font.reset")

rex.bind("cmd+0", "pane.balance")

local TERM = "com.superlogical.terminal"

local function popup(cwd, script, ...)
  local _, err = rex.session.new_layer{
    bounds = { 0.075, 0.175, 0.85, 0.65 },
    focus = true,
    layout = rex.layout.block{
      flavor = TERM .. ".shell",
      options = { cwd = cwd, command = { "sh", "-c", script, "sh", ... } },
    },
  }
  if err ~= nil then error(err, 0) end
end

-- insert paths (from git root) into the pane, @-prefixed for AI tools
local insert_files = [[
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)" || exit 0
if [ "$2" = 1 ]; then quote='s/ /\\ /g; s/^/@/'; else quote="s/'/'\\\\''/g; s/.*/'&'/"; fi
out=$(fd --type f --hidden --follow --exclude .git |
  fzf --multi --reverse --header='[Insert Files]' \
      --preview='bat --style=numbers --color=always {}' --preview-window=right:55% |
  sed "$quote" | tr '\n' ' ')
[ -n "$out" ] && rex send -b "$1" "$out"
]]

rex.action{
  name = "insert_files",
  title = "Insert Files…",
  run = function(ctx)
    local p = rex.block.call(TERM, "process", { block_id = ctx.block_id }) or {}
    local fg = p.foreground or {}
    local ai = (fg.argv0 or ""):match("claude") or (fg.argv0 or ""):match("codex") or (fg.argv0 or ""):match("opencode")
    popup(fg.cwd, insert_files, ctx.block_id, ai and "1" or "0")
  end,
}

-- new session from a zoxide directory, named after it; ctrl-n creates a subfolder
local zoxide_session = [[
out=$(zoxide query -l | fzf --reverse --expect=ctrl-n --header='[New Session]  ctrl-n: new folder')
key=$(printf '%s\n' "$out" | head -1); dir=$(printf '%s\n' "$out" | sed -n 2p)
[ -z "$dir" ] && exit 0
if [ "$key" = ctrl-n ]; then
  printf 'New folder in %s/: ' "$dir"; read -r sub; [ -z "$sub" ] && exit 0
  dir="$dir/$sub"; mkdir -p "$dir" && zoxide add "$dir" || exit 1
fi
name=$(basename "$dir" | tr '.: ' '---')
id=$(rex ls --json | jq -r --arg l "$name" '.sessions[]? | select(.label == $l) | .session_id' | head -1)
[ -z "$id" ] && id=$(rex new "$name" -c "$dir" --json | jq -r .session_id)
rex -C "$1" do session.select session_id="$id"
]]

rex.action{
  name = "zoxide_session",
  title = "New Session from Zoxide…",
  run = function(ctx)
    popup(nil, zoxide_session, ctx.client_id)
  end,
}

rex.bind("cmd+o", "insert_files")
rex.bind("cmd+j", "zoxide_session")
