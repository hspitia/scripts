#!/bin/bash

sound="${HOME}/.sounds/echime.wav"

    while true
    do
        export DISPLAY=:0.0
        battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
        if [ "$battery_level" != "" ]; then
            if on_ac_power; then
                if [ $battery_level -ge 70 ]; then
                    notify-send "Battery charging above 70%. Please unplug your AC adapter!" "Charging: ${battery_level}% "
                    aplay $sound
                    sleep 20
                    if on_ac_power; then
                        gnome-screensaver-command -l   ## lock the screen if you don't unplug AC adapter after 20 seconds
                    fi
                 fi
            else
                 if [ $battery_level -le 40 ]; then
                    notify-send "Battery is lower 40%. Need to charging! Please plug your AC adapter." "Charging: ${battery_level}%"
                    aplay $sound
                    sleep 20
                    if ! on_ac_power; then
                        gnome-screensaver-command -l   ## lock the screen if you don't plug AC adapter after 20 seconds
                    fi
                 fi
            fi
        fi

        sleep 300 # 300 seconds or 5 minutes
    done

# #!/bin/bash

# while true
# do
#     export DISPLAY=:0.0
#     battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
#     if [ $? -eq 0 ]; then
#         if [ $battery_level -ge 75 ]; then
#             notify-send -u critical "Battery charging above 70% (or nearing it). Please unplug your AC adapter!" "Charging: ${battery_level}% "
#             aplay /home/zack/startup/beep-01a.wav
#         fi
#     else
#         if [ $battery_level -le 45 ]; then
#             notify-send -u critical "Battery is lower 40% (or nearing it). Please plug your AC adapter." "Charging: ${battery_level}%"
#             aplay /home/zack/startup/beep-01a.wav
#         fi

#         if [ $battery_level -le 15 ]; then
#             notify-send -u critical "Battery is critically low. System will shut-down in 5 minutes." "Charging: ${battery_level}%"
#             aplay /home/zack/startup/beep-01a.wav
#             sleep 300
#             on_ac_power
#         if [ $? != 0 ]; then
#             notify-send -u critical "System will shut-down now." "Charging: ${battery_level}%"
#             shutdown -h 10
#         fi
#         fi
#     fi
#         sleep 300 # 300 seconds or 5 minutes
# done
