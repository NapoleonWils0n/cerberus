#!/bin/sh

# sauron - w3m

# current link under cursor in w3m
url="${W3M_CURRENT_LINK}"   

if [ -n "${url}" ]; then
   result=$(echo "${url}" | \
            grep -oP '(?<=google.com\/url\?q=)[^&]*(?=&)' \
            | sed -e "s/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g" | xargs -0 echo -e)
   [ -n "${result}" ] && url="${result}"
else
    url="${W3M_URL}"
fi


# mpv fullscreen on second display and taskspooler
fullscreen() {
      ts mpv --no-terminal --fs --fs-screen=1 "${url}" 1>/dev/null 
}

# mpv and taskspooler
video() {
      ts mpv --no-terminal "${url}" 1>/dev/null
}

dash () {
      dash-ffmpeg -i "${url}"
}

# copy url to the clipboard
copy() {
    printf "%s\n" "${url}" | xclip -i -selection clipboard 1>/dev/null
}

# open link in browser
open() {
      xdg-open "${url}"
}

# yt-dlp and taskspooler
ytdlp() {
      ts \
      yt-dlp \
      --ignore-config \
      --no-playlist \
      --restrict-filenames \
      -f 'bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9]+bestaudio/best' \
       -o "${HOME}/Downloads/%(title)s.%(ext)s" \
      "${url}" 1>/dev/null
}

# aria2c and taskspooler
aria2c() {
      ts \
      yt-dlp \
      --ignore-config \
      --no-playlist \
      --restrict-filenames \
      -f 'bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9]+bestaudio/best' \
      --downloader aria2c --downloader-args aria2c:'-c -j 3 -x 3 -s 3 -k 1M' \
       -o "${HOME}/Downloads/%(title)s.%(ext)s" \
      "${url}" 1>/dev/null
}

# ffmpeg and taskspooler
ffmpeg() {
      ts \
      yt-dlp \
      --ignore-config \
      --no-playlist \
      --restrict-filenames \
      -f 'bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9]+bestaudio/best' \
      --downloader ffmpeg --downloader-args ffmpeg:'-hide_banner -stats -v panic' \
       -o "${HOME}/Downloads/%(title)s.%(ext)s" \
      "${url}" 1>/dev/null
}

# download with yt-dlp with sponsorblock to remove sponsor
sponsorblock_download() {
      ts \
      yt-dlp \
      --ignore-config \
      --no-playlist \
      --sponsorblock-remove all \
      -f 'bestvideo[height<=1080][vcodec!=?vp9]+bestaudio[acodec!=?opus]' \
      -o "$HOME/Downloads/%(title)s.%(ext)s" \
      "${url}" 1>/dev/null
}

# mpd and taskspooler
audio() {
      ts pinch -i "${url}" 1>/dev/null 
}

# streamlink and taskspooler
streamlink() {
      ts streamlink -o "${HOME}/Downloads/{title}-{time}.mkv" "${url}" 1080p,720p 1>/dev/null
}

transmission () {
    transmission-remote --add "${url}"
}

# fzf prompt variables spaces to line up menu options
audio_ts='audio        - mpd play audio'
copy='copy         - copy url'
dash='dash         - combine dash streams and pipe into mpv'
ytdlp_ts='yt-dlp       - yt-dlp download links'
aria2c_ts='aria2c       - aria2c download links'
ffmpeg_ts='ffmpeg       - ffmpeg download links'
open='open         - open link in browser'
sponsorblock_ts='sponsorblock - sponsorblock yt-dlp'
fullscreen_ts='fullscreen   - mpv play fullscreen on second display'
video_ts='video        - mpv play video on current display'
streamlink_ts='streamlink   - streamlink'
transmission_remote='transmission - add torrent or magnet link'

# fzf prompt to specify function to run on links from ytfzf
menu=$(printf "%s\n" \
	      "${fullscreen_ts}" \
	      "${video_ts}" \
	      "${dash}" \
	      "${ytdlp_ts}" \
	      "${aria2c_ts}" \
	      "${ffmpeg_ts}" \
	      "${copy}" \
	      "${open}" \
	      "${audio_ts}" \
	      "${transmission_remote}" \
	      "${sponsorblock_ts}" \
	      "${streamlink_ts}" \
	      | fzf-tmux -d 32% --delimiter='\n' --prompt='Pipe links to: ' --info=inline --layout=reverse --no-multi)

case "${menu}" in
   audio*) audio;;
   aria2c*) aria2c;;
   copy*) copy;;
   dash*) dash;;
   open*) open;;
   sponsor*)sponsorblock_download ;;
   ffmpeg*) ffmpeg;;
   fullscreen*) fullscreen;;
   streamlink*) streamlink;;
   transmission*) transmission;;
   video*) video;;
   yt-dlp*) ytdlp;;
   *) exit;;
esac
