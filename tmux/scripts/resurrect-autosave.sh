#!/usr/bin/env bash
# Saves the tmux layout with tmux-resurrect whenever a session is created or
# closed. The session-created and session-closed hooks in tmux.conf call this.
#
# We wait a few seconds before saving because smug creates the session first
# and then adds its windows one at a time. Saving right away would only record
# the first window.
#
# We also skip the save until @resurrect-autosave is on. When tmux starts, it
# creates a fresh session before continuum has restored the last save. Saving
# at that moment would replace the last good save with a single empty session.
# tmux.conf turns the option on once a restore or a manual save finishes.

sleep "${1:-5}"
ready_at=$(date +%s)

[ "$(tmux show-option -gqv @resurrect-autosave)" = "on" ] || exit 0

# A save takes a few seconds. If two saves overlap, the older one can finish
# last and bring back a session we just closed. The lock makes each save wait
# for the previous one. We break the lock after a minute in case a save died
# without removing it.
lock="${TMPDIR:-/tmp}/tmux-resurrect-autosave.lock"
waited=0
until mkdir "$lock" 2>/dev/null; do
  if [ "$waited" -ge 60 ]; then
    rm -rf "$lock"
    waited=0
  fi
  sleep 1
  waited=$((waited + 1))
done
trap 'rm -rf "$lock"' EXIT

# A restore creates every session at once, and each one starts this script.
# Once one save has started after our wait ended, it already includes
# everything we would save, so the rest of the queue can stop here.
stamp="${TMPDIR:-/tmp}/tmux-resurrect-autosave.last"
[ "$(cat "$stamp" 2>/dev/null || echo 0)" -gt "$ready_at" ] && exit 0
date +%s > "$stamp"

"$HOME/.config/tmux/plugins/tmux-resurrect/scripts/save.sh" quiet
