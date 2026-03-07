#!/usr/bin/env sh

NOW_PLAYING=$(osascript <<'EOF'
  if app_is_running("Spotify") then
    tell application "Spotify"
      if player state is playing then
        set track_name to name of current track
        set artist_name to artist of current track

        if artist_name > 0
          return "󰋋 " & track_name & " - " & artist_name
        else
          return "󰋋 ~" & track_name
        end if
      else
        return "󰋋 paused"
      end if
    end tell
  end if

  on app_is_running(app_name)
    tell app "System Events" to (name of processes) contains app_name
  end app_is_running
EOF
)

echo "$NOW_PLAYING"
