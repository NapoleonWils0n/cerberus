#!/bin/sh
 
# Usage:
#
# adduser [-a] <USERNAME> <LONGNAME> <PRIMARY_GID> [ <HOME_DIRECTORY> [ <UID> ]]
#
# -a: Make the user an admin user.
# USERNAME: The Mac OS X "short name", e.g. jdoe
# LONGNAME: The Mac OS X "real name", e.g. "John Doe"
# PRIMARY_GID: The primary group ID.
# HOME_DIRECTORY: The user's home directory.  Leave blank to use /Users/username.
#                 The script attempts to create this directory if it does not exist.A
# UID: The user ID for the new user.  Leave blank for the script to automatically
#      choose the first unused ID at or above MINUID (currently 501).
 
ADMIN="user"
if [ "$1" = "-a" ] ; then
    ADMIN="admin user"
    shift
fi
 
USERNAME="$1"
LONGNAME="$2"
PRIMARY_GID="$3"
HOMEDIR="$4" # Optional
NEWUID="$5" # Optional
 
MINUID=501
DOMAIN="."
 
# Must have newline here.
IFS="
"
 
# /*!
#     @abstract Checks to see if a long name is reasonable.
#     @discussion Ideally, this should do more checks.
#  */
valid_username()
{
    local NAME="$1"
 
    if [ "$NAME" = "" ] ; then
        return 1;
    fi
 
    return 0;
}
 
# /*!
#     @abstract Checks to see if a long name is reasonable.
#     @discussion
#         Checking for non-empty strings is good enough for now,
#         but ideally, this should also check for duplicates.
#         The code doesn't do this because there's no good way
#         that doesn't involve a huge file and grep.
#  */
valid_longname()
{
    local NAME="$1"
 
    if [ "$NAME" = "" ] ; then
        return 1;
    fi
    return 0
}
 
# /*!
#     @abstract Checks to see if a (numeric) group ID is reasonable.
#  */
valid_gid()
{
    local NEWGID="$1"
 
    # Empty primary GID is illegal.
    if [ "$NEWGID" = "" ] ; then
        return 1;
    fi
 
    local NEWGIDSTR="$(printf "%d" "$NEWGID" 2> /dev/null)"
 
    if [ "$NEWGIDSTR" != "$NEWGID" ] ; then
        return 1;
    fi
 
    return 0;
}
 
# /*!
#     @abstract Checks to see if a (numeric) user ID is reasonable.
#  */
valid_uid()
{
    local NEWUID="$1"
 
    # Empty UID means "choose one for me"
    if [ "$NEWUID" = "" ] ; then
        return 0;
    fi
 
    local NEWUIDSTR="$(printf "%d" "$NEWUID" 2> /dev/null)"
 
    if [ "$NEWUIDSTR" != "$NEWUID" ] ; then
        return 1;
    fi
 
    return 0;
}
 
# /*!
#     @abstract Creates an associative pseudo-array for UID to username mapping.
#  */
initUIDMap()
{
    local SKIPUSER="$1"
 
    local USERS="$(dscl "$DOMAIN" -list /Users)"
 
    for i in $USERS ; do
        if [ "$i" != "$SKIPUSER" ] ; then
            eval "UID_$(dscl "$DOMAIN" -read /Users/"$i" UniqueID 2>/dev/null | sed 's/UniqueID: //' | sed 's/-/MINUS/')=\"$i\""
        fi
    done
}
 
# /*!
#     @abstract Looks up a UID in the pseudo-array and maps it to a username
#  */
uidToName()
{
    local CHECKUID="$1"
 
    local CHECKUID_ENCODED="$(echo "$CHECKUID" | sed 's/-/MINUS/')"
 
 
    eval echo '$UID_'$CHECKUID_ENCODED
}
 
# /*!
#     @abstract Finds the next unused UID.
#  */
assignUID()
{
    initUIDMap
 
    # An error here means somebody screwed up MINUID.
    local POS=$MINUID
 
    while true ; do
        # echo "Trying $POS" 1>&2
        local TEMPNAME="$(uidToName $POS)"
        if [ "$TEMPNAME" = "" ] ; then
            echo $POS
            return;
        fi
        POS="$(expr $POS '+' 1)"
    done
}
 
# /*!
#     @abstract Returns success if no other user has the chosen UID.
#  */
uid_not_conflicting()
{
    local NEWUID="$1"
    local NEWUSER="$2"
 
    initUIDMap "$NEWUSER"
 
    local TEMPNAME="$(uidToName "$NEWUID")"
 
    if [ "$TEMPNAME" != "" ] ; then
        return 1;
    fi
 
    return 0
}
 
 
while ! valid_username "$USERNAME" ; do
    printf "Enter username: "
    read USERNAME
done
 
while ! valid_uid  "$NEWUID" ; do
    printf "Invalid UID specified.  Enter desired UID: "
    read NEWUID
done
 
while ! valid_gid  "$PRIMARY_GID" ; do
    printf "Invalid group ID specified.  Enter desired GID: "
    read PRIMARY_GID
done
 
while ! valid_longname "$LONGNAME" ; do
    printf "Invalid long name specified.  Enter desired long name: "
    read LONGNAME
done
 
 
# Test code
### echo "UID Conflict check:"
### uid_not_conflicting "501" "dg" # Test this first or else.
### echo "$? should be 0"
### uid_not_conflicting "501" "Schlomo"
### echo "$? should be 1"
 
### echo "First free UID is $(assignUID)"
 
dscl $DOMAIN -read /Users/"$USERNAME" > /dev/null 2>&1
if [ $? = 0 ] ; then
    echo "Failed.  A user with that name already exists.." 1>&2
    exit -1
fi
 
dscl $DOMAIN -create /Users/"$USERNAME"
 
if [ $? != 0 ] ; then
    echo "Failed.  User could not be created." 1>&2
    exit -1
fi
 
dscl $DOMAIN -create /Users/"$USERNAME" UserShell /bin/bash
dscl $DOMAIN -create /Users/"$USERNAME" RealName "$LONGNAME"
if [ "$NEWUID" = "" ] ; then
    NEWUID="$(assignUID)"
fi
dscl $DOMAIN -create /Users/"$USERNAME" UniqueID $NEWUID
 
while ! uid_not_conflicting "$NEWUID" "$USERNAME"; do
    echo "A user with ID $NEWUID exists already.  Assigning a new UID." 1>&2
    OLDUID="$NEWUID"
    NEWUID="$(assignUID)"
    dscl $DOMAIN -change /Users/"$USERNAME" UniqueID "$OLDUID" "$NEWUID"
done
 
dscl $DOMAIN -create /Users/"$USERNAME" PrimaryGroupID $PRIMARY_GID
 
if [ "$HOMEDIR" = "" ] ; then
    dscl $DOMAIN -create /Users/"$USERNAME" NFSHomeDirectory /Users/"$USERNAME"
    if [ ! -d "/Users/$USERNAME" ] ; then
        mkdir "/Users/$USERNAME"
    fi
else
    dscl $DOMAIN -create /Users/"$USERNAME" NFSHomeDirectory "$HOMEDIR";
fi
 
dscl $DOMAIN -passwd /Users/"$USERNAME" "*"
# passwd "$USERNAME"
 
UUID="$(/usr/bin/uuidgen)"
dscl $DOMAIN -create /Users/"$USERNAME" GeneratedUID "$UUID"
 
if [ "$ADMIN" = "admin user" ] ; then
    dscl $DOMAIN -append /Groups/admin GroupMembership "$USERNAME"
    dscl $DOMAIN -append /Groups/admin GroupMembers "$UUID"
fi
 
echo "Added $ADMIN $USERNAME with ID $NEWUID and UID $UUID.  Please remember to set a password for the user."
