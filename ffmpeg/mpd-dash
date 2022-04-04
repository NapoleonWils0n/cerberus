#!/bin/sh

# create a dash mpd file from a file or url
# https://ffmpeg.org/ffmpeg-formats.html#dash-2

# script usage
usage ()
{
# if argument passed to function echo it
[ -z "${1}" ] || echo "! ${1}"
# display help
echo "\
# create a dash mpd file

$(basename "$0") -i input -v 1000k -a 44100 -p high -o output.mpd
-i input # input file or url
-v 1000k # video bitrate :optional agument # if option not provided defaults to 1000k
-a 44100 # audio rate :optional agument # if option not provided defaults to 44100
-p high # video profile :optional agument # if option not provided defaults to high
-o output.mpd # ouput file :optional agument # if option not provided defaults to output-date-time.mpd"
exit 2
}

# error messages
INVALID_OPT_ERR='Invalid option:'
REQ_ARG_ERR='requires an argument'
WRONG_ARGS_ERR='wrong number of arguments passed to script'

# if script is run arguments pass and check the options with getopts,
# else display script usage and exit
[ $# -gt 0 ] || usage "${WRONG_ARGS_ERR}"

# defaults for variables if not defined
output_default="output-$(date +"%Y-%m-%d-%H-%M-%S").mpd"
video_bitrate_default='1000k'
audio_bitrate_default='44100'
profile_default="high"

# getopts check and validate options
while getopts ':i:v:a:p:o:h' opt
do
  case ${opt} in
     i) input="${OPTARG}";;
     v) video="${OPTARG}";;
     a) audio="${OPTARG}";;
     p) profile="${OPTARG}";;
     o) output="${OPTARG}";;
     h) usage;;
     \?) usage "${INVALID_OPT_ERR} ${OPTARG}" 1>&2;;
     :) usage "${INVALID_OPT_ERR} ${OPTARG} ${REQ_ARG_ERR}" 1>&2;;
  esac
done
shift $((OPTIND-1))

# ffmpeg create mpd function
create_mpd () {
ffmpeg -re -i "${input}" -map 0 -c:a aac -c:v libx264 \
-b:v:0 "${video:=${video_bitrate_default}}" \
-profile:v:0 "${profile:=${profile_default}}" -bf 1 -keyint_min 120 -g 120 -sc_threshold 0 \
-b_strategy 0 -ar:a:0 "${audio:=${audio_bitrate_default}}" -use_timeline 1 -use_template 1 \
-window_size 5 -adaptation_sets "id=0,streams=v id=1,streams=a" \
-f dash "${output:=${output_default}}"
}

# run create mpd function
create_mpd
