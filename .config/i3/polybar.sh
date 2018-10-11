#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
for bar in $POLYBAR_BARS; do
	echo "Starting polybar: $bar"
    polybar "$bar" &
done
