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

# Prefer terminal-notifier: posting "as" Ghostty (-sender) makes clicking the
# notification activate Ghostty instead of the osascript host (Script Editor).
notifier=$(command -v terminal-notifier 2>/dev/null)
for cand in /opt/homebrew/bin/terminal-notifier /usr/local/bin/terminal-notifier; do
  [[ -n "$notifier" ]] && break
  [[ -x "$cand" ]] && notifier="$cand"
done

if [[ -n "$notifier" ]]; then
  # terminal-notifier 2.0 stays resident to back the delivered notification, so
  # it would accumulate one process per event. Click->activate-Ghostty is handled
  # by LaunchServices via -sender (not the running process), so reap our own
  # stale instances first, keeping at most one alive.
  pkill -f 'terminal-notifier.*-sender com.mitchellh.ghostty' 2>/dev/null

  # args are passed as argv (no shell/AppleScript eval), so text can't inject
  "$notifier" \
    -title "$title" \
    -message "$body" \
    -sound "$sound" \
    -sender com.mitchellh.ghostty \
    -group "claude-$label" >/dev/null 2>&1
else
  # Fallback: argv-based osascript so notification text can't inject AppleScript.
  # Clicking this one activates Script Editor (no way to retarget from pure AS).
  osascript - "$title" "$body" "$sound" >/dev/null 2>&1 <<'EOF'
on run argv
  display notification (item 2 of argv) with title (item 1 of argv) sound name (item 3 of argv)
end run
EOF
fi
exit 0
