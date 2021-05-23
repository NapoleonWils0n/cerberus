#!/bin/sh

# sauron - w3m

# current link under cursor in w3m
url="${W3M_CURRENT_LINK}"   

# if the current link contains a url pipe it into grep,
# remove the google redirect and decode the url
# if the current link is empty set the url to the page url
if [ ! -z "${url}" ]; then
   result=$(echo "${url}" | \
            grep -oP '(?<=google.com\/url\?q=)[^&]*(?=&)' \
            | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));")
   [ ! -z "${result}" ] && url="${result}" || url="${url}"
else
    url="${W3M_URL}"
fi

# mpd and taskspooler
audio() {
      tsp pinch -i "${url}" 1>/dev/null 
}

copy_link() {
      echo -n "${url}" | xsel -b 1>/dev/null 
}

# youtube-dl and taskspooler
download() {
      tsp \
      youtube-dl -f 'bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9]+bestaudio/best' \
      --restrict-filenames \
      --no-playlist \
      --ignore-config \
       -o "~/Downloads/%(title)s.%(ext)s" \
      "${url}" 1>/dev/null
}

# mpv fullscreen on second display and taskspooler
fullscreen() {
      tsp mpv --fs --screen=1 "${url}" 1>/dev/null 
}

# mpv and taskspooler
video() {
      tsp mpv --no-terminal "${url}" 1>/dev/null
}

# fzf prompt variables spaces to line up menu options
audio_tsp='audio      - mpd play audio'
copy_tsp='copy       - xsel copy url under the cusor to the clipboard'
download_tsp='download   - youtube-dl download links'
fullscreen_tsp='fullscreen - mpv play fullscreen on second display'
video_tsp='video      - mpv play video on current display'

# fzf prompt to specify function to run on links from ytfzf
menu=$(printf "%s\n" \
	      "${audio_tsp}" \
	      "${copy_tsp}" \
	      "${download_tsp}" \
	      "${fullscreen_tsp}" \
	      "${video_tsp}" \
	      | fzf-tmux -d 15% --delimiter='\n' --prompt='Pipe links to: ' --info=inline --layout=reverse --no-multi)

# case statement to run function based on fzf prompt output
case "${menu}" in
   audio*) audio;;
   copy*) copy_link;;
   download*) download;;
   fullscreen*) fullscreen;;
   video*) video;;
   *) exit;;
esac
