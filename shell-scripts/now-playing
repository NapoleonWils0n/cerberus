#!/bin/sh

# now-playing

# edit your ~/.config/dunst/dunstrc and set the max_icon_size to 300
# max_icon_size = 300

# get the metadata from the active player
#====================================================================

metadata=$(playerctl metadata --format 'title=[{{ title }}] artist=[{{ artist }}] player=[{{ playerName }}] status=[{{ status }}] arturl=[{{ mpris:artUrl }}] position=[{{ duration(position) }}] duration=[{{ duration(mpris:length) }}] url=[{{ xesam:url }}]')


# variables
#====================================================================

# dunst title - truncate length to 40 charcters with awk
title=$(echo "${metadata}" | awk -F'[][]' -v RS="" '/title/ {print $2}' | awk 'length > 40{$0=substr($0,0,41)"..."}1')

# artist
artist=$(echo "${metadata}" | awk -F'[][]' '/artist/ {print $4}')

# artist fallback text
artist_fallback='Unknown'

# player name capitalized with awk
player=$(echo "${metadata}" | awk -F'[][]' -v RS=" " '/player/ {print $2}' | awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1')

# player status
status=$(echo "${metadata}" | awk -F'[][]' -v RS=" " '/status/ {print $2}')

# playhead position for ffmpeg thumbnail
position=$(echo "${metadata}" | awk -F'[][]' -v RS=" " '/position/ {print $2}')

# position fallback
position_fallback='Unknown'

# video duration
duration=$(echo "${metadata}" | awk -F'[][]' -v RS=" " '/duration/ {print $2}')

# position fallback
duration_fallback='Unknown'

# url
url=$(echo "${metadata}" | awk -F'[][]' -v RS=" " '/url/ {print $2}' | tr -d '\n')

# dunst icon using mpris:artUrl
#====================================================================

# icon
icon=$(echo "${metadata}" | awk -F'[][]' -v RS=" " '/arturl/ {print $2}')

# expr check if icon starts with https://
iconcheck=$(expr "${icon}" : "http.*://")

# if urlcheck not equal to 0 its a http link
if [ "${iconcheck}" -ne 0 ]; then
  # check if arturl is empty
  if [ -z "${arturl}" ]; then
    imageurl=$(echo "${metadata}" | awk -F'[][]' -v RS=" " '/arturl/ {print $2}' | sed 's#file://##')
    curltmp=$(mktemp /tmp/playerctlXXX --suffix=.jpg)
    imagetmp=$(mktemp /tmp/playerctlXXX --suffix=.jpg)
    curl "${imageurl}" -o "${curltmp}" 2>/dev/null
    convert "${curltmp}" -resize x120 "${imagetmp}"
    icon="${imagetmp}" # set icon to ffmpeg thumbail
  else
    imagetmp=$(mktemp /tmp/playerctlXXX --suffix=.jpg)
    convert "${icon}" -resize x120 "${imagetmp}"
  fi
fi

# fallback icon
icon_fallback='/usr/share/icons/Adwaita/48x48/legacy/face-smile.png'


# ffmpeg extract thumbnail
#====================================================================

# extract thumbnail from video
thumbnail () {
  ffmpeg \
  -hide_banner \
  -stats -v panic \
  -ss "${position}" \
  -y \
  -i "${url}" \
  -q:v 2 -f image2 \
  -vframes 1 \
  -filter:v scale="-1:120" \
  "${output}" 2>/dev/null
}


# check if url starts with file://
#====================================================================

# expr check if url starts with file://
urlcheck=$(expr "${url}" : "file://")

# if urlcheck equals 7 matches file://
if [ "${urlcheck}" -eq 7 ]; then
  # remove file:// replace %20 with a space and remove new line
  url=$(echo "${metadata}" | awk -F'[][]' -v RS=" " '/url/ {print $2}' | sed 's#file://##;s#%5B#[#;s#%5D#]#;s#%20#\ #g' | tr -d '\n')
  output=$(mktemp /tmp/playerctlXXX --suffix=.png)
  thumbnail # ffmpeg thumbnail function
  icon="${output}" # set icon to ffmpeg thumbail
fi


# body - artist, player, status, duration and position + notify-send
#====================================================================

# check if duration is empty
if [ -z "${duration}" ]; then
    body="Artist: ${artist:=${artist_fallback}}\nPlayer: ${player}\nStatus: ${status}\nDuration: ${duration_fallback}\nPosition: ${position_fallback}"
    notify-send -i "${icon:=${icon_fallback}}" "${title}" "${body}"
else
    body="Artist: ${artist:=${artist_fallback}}\nPlayer: ${player}\nStatus: ${status}\nDuration: ${duration}\nPosition: ${position}"
    position_seconds=$(echo "${position}" | awk -F: 'NF==3 { printf("%s\n"), ($1 * 3600) + ($2 * 60) + $3 } NF==2 { print ($1 * 60) + $2 } NF==1 { printf("$s\n"), 0 + $1 }')
    duration_seconds=$(echo "${duration}" | awk -F: 'NF==3 { printf("%s\n"), ($1 * 3600) + ($2 * 60) + $3 } NF==2 { print ($1 * 60) + $2 } NF==1 { printf("$s\n"), 0 + $1 }')
    position_percent=$(echo "${position_seconds} ${duration_seconds}" | awk '{ print ($1 / $2) * 100 }' | awk -F. '{ print $1 }')
    notify-send -h "int:value:${position_percent}" -i "${icon:=${icon_fallback}}" "${title}" "${body}"
fi
