#!/usr/bin/env bash
#
# Shared helpers for the dotfiles scripts. Source this, don't run it.

collision_action=""   # skip|overwrite|backup, set by the last prompt_collision
link_all_action=""    # sticky [S]/[O]/[B] answer, reused for the rest of the run

# Ask what to do about $1, an existing path in the way of a symlink.
# Sets $collision_action. Returns 1 when there was nobody to ask, 2 on [q]uit.
prompt_collision () {
  local dst=$1 action=

  if [[ -n "$link_all_action" ]]; then
    collision_action=$link_all_action
    return 0
  fi

  # No terminal to ask on (CI, a detached run) — fail the way this used to.
  # `-r` is not enough: /dev/tty passes it and still fails to open.
  if ! : 2>/dev/null </dev/tty; then
    dotlog "error" "$dst already exists; re-run interactively to resolve"
    return 1
  fi

  while true; do
    dotlog "user" "$dst already exists, what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all, [q]uit?"
    if ! read -r -n 1 action </dev/tty; then
      echo
      dotlog "error" "no answer; $dst left alone"
      return 1
    fi
    echo

    case "$action" in
      s) collision_action=skip;      return 0 ;;
      o) collision_action=overwrite; return 0 ;;
      b) collision_action=backup;    return 0 ;;
      S) link_all_action=skip;      collision_action=skip;      return 0 ;;
      O) link_all_action=overwrite; collision_action=overwrite; return 0 ;;
      B) link_all_action=backup;    collision_action=backup;    return 0 ;;
      q) dotlog "info" "aborted; $dst left alone"; return 2 ;;
    esac
  done
}
