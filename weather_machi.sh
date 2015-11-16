#!/bin/sh

URL='http://www.accuweather.com/en/in/bangalore/204108/weather-forecast/204108'
#wget -q -O- "$URL"
#wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", "$12"°" }'| head -1


wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $10"°C",$14}' | head -n 1
