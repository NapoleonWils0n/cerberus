#!/bin/bash

VIDEOFILE=`echo "$VIDEOURL" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_@%-]*\.(mkv|mp4|avi|flv)'`
M3U8=`echo "$VIDEOURL" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_,@&%-]*\.(m3u8)'`
M3U8TOKEN=`echo "$VIDEOURL" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_@%-]*\.(m3u8)\?token=[a-zA-Z0-9&=]*'`
M3U8UAG=`echo "$VIDEOURL" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_@%-]*\.(m3u8)[a-zA-Z0-9?&=%*]*[^|]'`
XFORWARD=`echo "$VIDEOURL" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_@%-]*\.(m3u8)\|X-Forwarded-For=[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
XFORWARDIP=`echo "$XFORWARD" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
USEREF=`echo "$VIDEOURL" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_-]*\|User-Agent=[a-zA-Z0-9/.()[:blank:],:;%+-]*\&Referer=(http|https)(://|%3A%2F%2F)[a-zA-Z%0-9./?=_-]*'`
USERAGENT=`echo "$VIDEOURL" | grep -Eo 'u?User-a?Agent=[a-zA-Z0-9/.()[:blank:],:;%+_-]*[^&]'`
REFERER=`echo "$VIDEOURL" | grep -Eo 'Referer=(http|https)(://|%3A%2F%2F)[a-zA-Z%0-9./?=_-]*' | sed 's/Referer=//'`
M3U8USERAGENT=`echo "$VIDEOURL" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_@%-]*\.(m3u8)[a-zA-Z0-9?&=%*]*\|u?User-a?Agent=[a-zA-Z0-9/.()[:blank:],:;%+_-]*[^&]'`
M3U8USERAGENT2=`echo "$VIDEOURL" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_@%-]*\.(m3u8)[a-zA-Z0-9?&=%*]*\|u?User-a?Agent=[a-zA-Z0-9/.()[:blank:],:;%+_-]*[^&]'`
M3U8UAGENTREFERER=`echo "$VIDEOURL" | grep -Eo '(^http|https)://[a-zA-Z0-9:0-9./?=_&@%|()[:blank:],;-]*'`
M3U8UAGNTREF=`echo "$M3U8UAGENTREFERER" | grep -Eo '(^http|https)://[a-zA-Z0-9:0-9./?=_&@%-]*'`
REFUSERAGENT=`echo "$VIDEOURL" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_-]*\|Referer=(http|https)(://|%3A%2F%2F)[a-zA-Z%0-9./?=_-]*\&User-Agent=[a-zA-Z0-9/.()[:blank:],:;%+-]*'`
BEEB=`echo "$VIDEOURL" | grep -Eo '^(http|https)://[a-zA-Z0-9:0-9/.&;,~*?[:blank:]_=-]*'`
GVID=`echo "$VIDEOURL" | grep -Eo '^(http|https)://[a-zA-Z0-9:0-9/.&;,~*?_=-]*'`
RTMP=`echo "$VIDEOURL" | grep -Eo '^(rtmp|rtmpe)://[a-zA-Z0-9:0-9/.&;,~*?[:blank:]_=-]*'`
COOKIE=`echo "$VIDEOURL" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_-]*\|User-Agent=[a-zA-Z0-9/.()[:blank:],:;%+-]*&Cookie[a-zA-Z0-9.=-]*;[[:space:]]mediaAuth_v2=[a-zA-Z0-9]*'`
COOKIEUSERAGTENT=`echo "$COOKIE" | grep -Eo 'u?User-a?Agent=[a-zA-Z0-9/.()[:blank:],:;%+_-]*[^&]' | sed 's/u\?User-a\?Agent=//'`
COOKIEDOMAIN=`echo "$COOKIE" | grep -Eo '(http|https)://[a-zA-Z0-9.-]*[^/]' | sed 's/^http\(\|s\):\/\///g'`
COOKIEURL=`echo "$COOKIE" | grep -Eo 'Cookie=[a-zA-Z0-9.=-]*;[[:space:]]mediaAuth_v2=[a-zA-Z0-9]*' | sed 's/Cookie=//'`
COOKIEM3U8=`echo "$COOKIE" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_,@&%-]*\.(m3u8)'`