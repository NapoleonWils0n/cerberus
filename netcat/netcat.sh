#!/bin/bash
 
INFIFO="/tmp/infifo.$$"
OUTFIFO="/tmp/outfifo.$$"
 
# /*! Cleans up the FIFOs and kills the netcat helper. */
cleanup_daemon()
{
    rm -f "$INFIFO" "$OUTFIFO"
 
    if [ "$NCPID" != "" ] ; then
        kill -TERM "$NCPID"
    fi
 
    exit
}
 
# /*! @abstract Attempts to reconnect after a sigpipe. */
reconnect()
{
        PSOUT="$(ps -p $NCPID | tail -n +2 | tr -d '\n')"
        if [ "$PSOUT" = "" ] ; then
                cleanup_shttpd
        fi
        closeConnection 8 "$INFIFO"
}
 
trap cleanup_daemon SIGHUP
trap cleanup_daemon SIGTERM
trap reconnect SIGPIPE
trap cleanup_daemon SIGABRT
trap cleanup_daemon SIGTSTP
# trap cleanup_daemon SIGCHLD
trap cleanup_daemon SIGSEGV
trap cleanup_daemon SIGBUS
trap cleanup_daemon SIGQUIT
trap cleanup_daemon SIGINT
 
mkfifo "$INFIFO"
mkfifo "$OUTFIFO"
 
# /*! Reverses a string. */
reverseit()
{
    STRING="$1"
 
    REPLY=""
 
    while [ "$STRING" != "" ] ; do
        FIRST="$(echo "$STRING" | cut -c '1')"
        STRING="$(echo "$STRING" | cut -c '2-')"
        REPLY="$FIRST$REPLY"
    done
 
    echo "$REPLY"
}
 
while true ; do
    CONNECTED=1
    nc -l 4242 < $INFIFO > $OUTFIFO &
    NCPID=$!
 
    exec 8> $INFIFO
    exec 9<> $OUTFIFO
 
    while [ $CONNECTED = 1 ]  ; do
            read -u9 -t1 REQUEST
 
        if [ $? = 0 ] ; then
            # Read didn't time out.
            reverseit "$REQUEST" >&8
            echo "GOT REQUEST $REQUEST"
        fi
 
        CONNECTED="$(jobs -r | grep -c .)"
    done
done
