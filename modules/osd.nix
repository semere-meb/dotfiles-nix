{
  config,
  lib,
  pkgs,
  userVars,
  ...
}:

{
  home-manager.users."${userVars.username}" = {
    xdg.configFile."fnott/scripts/osd.sh" = {
      text = ''
        #!/usr/bin/env bash
        # usage: osd.sh [volume|brightness] [raise|lower|mute]

        ACTION=$1
        DIRECTION=$2

        if [ "$ACTION" = "volume" ]; then
            if [ "$DIRECTION" = "raise" ]; then
                pamixer -i 5
            elif [ "$DIRECTION" = "lower" ]; then
                pamixer -d 5
            elif [ "$DIRECTION" = "mute" ]; then
                pamixer -t
            fi

            # Query state
            VOLUME=$(pamixer --get-volume)
            MUTED=$(pamixer --get-mute-status)

            if [ "$MUTED" = "true" ]; then
                notify-send -h int:value:0 -h string:x-canonical-private-synchronous:volume -i audio-volume-muted -t 1000 "Muted"
            else
                notify-send -h int:value:"$VOLUME" -h string:x-canonical-private-synchronous:volume -i audio-volume-high -t 1000 "Volume: $VOLUME%"
            fi

        elif [ "$ACTION" = "brightness" ]; then
            if [ "$DIRECTION" = "raise" ]; then
                brightnessctl set 10%+
            elif [ "$DIRECTION" = "lower" ]; then
                brightnessctl set 10%-
            fi

            # Query state
            CURR=$(brightnessctl get)
            MAX=$(brightnessctl max)
            PCT=$(( (CURR * 100) / MAX ))

            notify-send -h int:value:"$PCT" -h string:x-canonical-private-synchronous:brightness -i display-brightness -t 1000 "Brightness: $PCT%"
        fi
      '';
      executable = true;
    };
  };
}
