#!/usr/bin/env python3

from pilfer import validate, regex, record, audio
import sys, re, getopt, os.path, mimetypes

# argv
argv = sys.argv[1:]

# shortcuts for imported functions
usage = validate.usage
checkurl = validate.checkurl
durationValidated = validate.durationValidated
splitUrl = regex.splitUrl
splitEquals = regex.splitEquals

# url and duration
result = []
tflag = '-t'

# options passed to script
options = []

#=================================================#
# main function
#=================================================#

def main(argv):
    ''' main function
    
    check number of arguments passed to script
    '''
    if len(argv) == 0: # no arguments passed to script
        print("No arguments passed to script")
        usage()    # display script usage
        sys.exit() # exit
    elif len(argv) > 4: # too many arguments passed to script
        print("Too many arguments passed to script")
        usage()    # display script usage
        sys.exit() # exit

    try:
        opts, args = getopt.getopt(argv, "hi:a:t:", ["help", "url", "audiourl", "time"])
    except getopt.GetoptError as err: 
        print(err)  # will print something like "option -x not recognized"
        usage()     # display script usage
        sys.exit(2) # exit

    for opt, arg in opts:
        options.append(opt) # store options for later
        if opt in ("-h", "--help"):
            # -h or --help = display help
            usage()
            sys.exit()
        elif opt == ("-i") and len(argv) == 2:
            # -i and url or text file
            result.append(checkurl(argv[1]))
            return result
        elif opt == ("-a") and len(argv) == 2:
            # -a and url or text file
            result.append(checkurl(argv[1]))
            return result
        elif opt == ("-t") and len(argv) == 2:
            # -t option on its own
            print("the -t option must be used after the -i option")
            usage()
            sys.exit()
        elif opt in ("-i", "-t") and len(argv) == 4:
            result.append(checkurl(argv[1]))
            result.append(durationValidated(argv[3]))
            return result
            if "-t" in opts[0]:
                # -t option used before -i option - invalid
                print("the -t option must be used after the -i option")
                usage()
                sys.exit()
        elif opt in ("-a", "-t") and len(argv) == 4:
            result.append(checkurl(argv[1]))
            result.append(durationValidated(argv[3]))
            return result
            if "-t" in opts[0]:
                # -t option used before -a option - invalid
                print("the -t option must be used after the -a option")
                usage()
                sys.exit()

        else:
            assert False, "unhandled option"

#=================================================#
# slice off script name from arguments
#=================================================#

def entry():
    main(sys.argv[1:])

    # the validated url
    url = result[0]

    # the url stored in a dictionary
    theUrl = splitUrl(url)
    
    # url dictionary keys lowercased for searching
    urlDict = {k.lower(): v for k, v in theUrl.items()}

    # ffmpeg dictionary to hold url and ffmpeg options
    ffmpegDict = {}

    if 'url' in urlDict:
        ul = urlDict['url']
        url = '{0}'.format(ul)
        ffmpegDict['url'] = url

    if 'user-agent' in urlDict:
        ua = urlDict['user-agent']
        useragent = "-user-agent '{0}'".format(ua)
        ffmpegDict['user-agent'] = useragent

    if 'referer' in urlDict:
        rf = urlDict['referer']
        referer = "-headers 'Referer: {0}'".format(rf)
        ffmpegDict['referer'] = referer

    if 'cookie' in urlDict:
        cd = re.search('(http|https)://[a-zA-Z0-9.-]*[^/]', url) # cookie domain name
        cookiedomain = cd.group()
        cookieurl = urlDict['cookie']
        cookie = "-cookies '{0}; path=/; {1};'".format(cookieurl, cookiedomain)
        ffmpegDict['cookie'] = cookie

    nltid = re.findall('nltid=[a-zA-Z0-9&%_*=]*', url) # nltid cookie in url

    if nltid:
        cd = re.search('(http|https)://[a-zA-Z0-9.-]*[^/]', url) # cookie domain name
        cookiedomain = cd.group()
        cookieurl = nltid[0]
        cookie = "-cookies '{0}; path=/; {1};'".format(cookieurl, cookiedomain)
        ffmpegDict['nltid'] = cookie

    payload = re.search('reqPayload=[a-zA-Z0-9/%]*', result[0]) # payload in result

    if payload:
        cd = re.search('(http|https)://[a-zA-Z0-9.-]*[^/]', url) # cookie domain name
        cookiedomain = cd.group()
        cookieurl = payload[0]
        cookie = "-cookies '{0}; path=/; {1};'".format(cookieurl, cookiedomain)
        ffmpegDict['cookie'] = cookie

    # http and rtmp regexes
    http = re.compile(r'^(http|https)://')
    rtmp = re.compile(r'^(rtmp|rtmpe)://')

    # check number of args passed to script
    if len(argv) == 2:
        if http.match(url):
            if options[0] == "-i":
                ffrec = record.ffmpeg(**ffmpegDict)
            elif options[0] == "-a":
                ffrec = audio.ffmpegaudio(**ffmpegDict)
        elif rtmp.match(url):
            if options[0] == "-i":
                rtmprec = record.rtmp(**ffmpegDict)
            elif options[0] == "-a":
                rtmprec = audio.rtmpaudio(**ffmpegDict)
    elif len(argv) == 4:
        ffmpegDict['tflag'] = tflag # add tflag and duration to ffmpegDict
        ffmpegDict['duration'] = result[1]
        if http.match(url):
            if options[0] == "-i":
                ffrec = record.ffmpeg(**ffmpegDict)
            elif options[0] == "-a":
                ffrec = audio.ffmpegaudio(**ffmpegDict)
        elif rtmp.match(url):
            if options[0] == "-i":
                rtmprec = record.rtmp(**ffmpegDict)
            elif options[0] == "-a":
                rtmprec = audio.rtmpaudio(**ffmpegDict)
