#!/bin/bash
#
# Desktop notification for Claude Code hook events (Notification + Stop).
# Reads hook JSON on stdin; labels the session by worktree (repo/branch) or
# directory name so parallel sessions are distinguishable.

input=$(cat)

event=$(jq -r '.hook_event_name // "Claude"' <<<"$input")
cwd=$(jq -r '.cwd // ""' <<<"$input")

# worktrunk layout: ~/Code/worktrees/{repo}/{branch} -> "repo/branch"
case "$cwd" in
  */worktrees/*) label="${cwd#*/worktrees/}" ;;
  *)             label="${cwd##*/}" ;;
esac
label=${label:-session}

case "$event" in
  Stop)
    title="Claude done · $label"
    body="Finished responding"
    sound="Glass"
    ;;
  Notification)
    title="Claude waiting · $label"
    body=$(jq -r '.message // "Needs your attention"' <<<"$input")
    sound="Funk"
    ;;
  *)
    title="Claude · $label"
    body="$event"
    sound="Glass"
    ;;
esac

# argv-based osascript so notification text can't inject AppleScript
osascript - "$title" "$body" "$sound" >/dev/null 2>&1 <<'EOF'
on run argv
  display notification (item 2 of argv) with title (item 1 of argv) sound name (item 3 of argv)
end run
EOF
exit 0
