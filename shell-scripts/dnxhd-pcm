#!/bin/sh

#===============================================================================
# convert video at 30fps to dnxhd and audio to pcm
#===============================================================================


#===============================================================================
# script usage
#===============================================================================

usage()
{
# if argument passed to function echo it
[ -z "${1}" ] || echo "! ${1}"
# display help
echo "\
# convert video to dnxhd and audio to pcm

$(basename "$0") -i infile.(mp4|mkv|mov|m4v|webm) -o outfile.mov
-i infile.(mp4|mkv|mov|m4v|webm)
-o outfile.mov :optional agument # if option not provided defaults to infile-name-dnxhd-date-time"
exit 2
}


#===============================================================================
# error messages
#===============================================================================

NOTFILE_ERR='not a file'
INVALID_OPT_ERR='Invalid option:'
REQ_ARG_ERR='requires an argument'
WRONG_ARGS_ERR='wrong number of arguments passed to script'


#===============================================================================
# check number of aruments passed to script
#===============================================================================

[ $# -gt 0 ] || usage "${WRONG_ARGS_ERR}"


#===============================================================================
# getopts check options passed to script
#===============================================================================

while getopts ':i:o:h' opt
do
  case ${opt} in
     i) infile="${OPTARG}"
	[ -f "${infile}" ] || usage "${infile} ${NOTFILE_ERR}";;
     o) outfile="${OPTARG}";;
     h) usage;;
     \?) usage "${INVALID_OPT_ERR} ${OPTARG}" 1>&2;;
     :) usage "${INVALID_OPT_ERR} ${OPTARG} ${REQ_ARG_ERR}" 1>&2;;
  esac
done
shift $((OPTIND-1))


#===============================================================================
# variables
#===============================================================================

infile_nopath="${infile##*/}"
infile_name="${infile_nopath%.*}"

# defaults for variables if not defined
outfile_default="${infile_name}-dnxhd.mov"


#===============================================================================
# functions
#===============================================================================

# dnxhd-pcm function
dnx () {
    ffmpeg \
    -hide_banner \
    -stats -v panic \
    -i "${infile}" \
    -c:v dnxhd \
    -c:a pcm_s16le \
    -s 1920x1080 \
    -r 30000/1001 \
    -b:v 145M \
    -pix_fmt yuv422p \
    -f mov \
    "${outfile:=${outfile_default}}"
}

# run the dnx function
dnx "${infile}"
