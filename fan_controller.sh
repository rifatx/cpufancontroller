#!/bin/bash

gpio export 5 out # set pin 11 to outpput

thermal_folder="/sys/devices/virtual/thermal/"
fan_state_file="/sys/class/gpio/gpio33/value"

while : ; do
	thermal_zones=$(find "$thermal_folder" -type d -name thermal_zone\*)
	temp=0
	c=0

	while IFS= read -r z; do
		temp=$(( $temp + $(cat "$z/temp") ))
		c=$(($c + 1))
	done < <(echo -e "$thermal_zones")
	
	temp=$(( $temp / $c / 1000 ))

	fan_state=$(cat "$fan_state_file")
	
	if (( $temp > 55 )); then
		fan_state="1"
	fi

	if (( $temp < 45 )); then
		fan_state="0"
	fi

	echo "$fan_state" > "$fan_state_file"

	sleep 5
done
