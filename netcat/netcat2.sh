#!/bin/bash
 
INFIFO="/tmp/infifo.$$"
OUTFIFO="/tmp/outfifo.$$"
 
INFIFO="/tmp/infifo.$$"
OUTFIFO="/tmp/outfifo.$$"
 
# /*! Cleans up the FIFOs and kills the netcat helper. */
cleanup_client()
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
 
trap cleanup_client SIGHUP
trap cleanup_client SIGTERM
trap reconnect SIGPIPE
trap cleanup_client SIGABRT
trap cleanup_client SIGTSTP
trap cleanup_client SIGCHLD
trap cleanup_client SIGSEGV
trap cleanup_client SIGBUS
trap cleanup_client SIGQUIT
trap cleanup_client SIGINT
 
mkfifo "$INFIFO"
mkfifo "$OUTFIFO"
 
nc localhost 4242 < $INFIFO > $OUTFIFO &
NCPID=$!
 
exec 8> $INFIFO
exec 9<> $OUTFIFO
 
while true ; do
    printf "String to reverse -> "
        read STRING
    echo "$STRING" >&8
    read -u9 REVERSED
    echo "$REVERSED"
done