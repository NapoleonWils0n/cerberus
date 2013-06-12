#!/bin/bash
 
# Usage:
#
# addgroup <GROUPNAME> <LONGNAME> [<GID> ]
#
# GROUPNAME: The Mac OS X "short name", e.g. admin
# LONGNAME: The Mac OS X "real name", e.g. "Administrators"
# GID: The group ID for the new group.  Leave blank for the script to automatically
#      choose the first unused ID at or above MINGID (currently 501).
#
 
 
GROUPNAME="$1"
LONGNAME="$2"
NEWGID="$3" # Optional
 
MINGID=501
 
DOMAIN="."
 
# Must have newline here.
IFS="
"
 
ADDGROUP="./addgroup.sh"
 
if [ -f "/usr/local/bin/addgroup" ] ; then
    ADDGROUP="/usr/local/bin/addgroup"
fi
 
# /*!
#     @abstract Checks to see if a group long name is reasonable.
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
 
    return 0;
}
 
# /*!
#     @abstract Checks to see if a group name is reasonable.
#     @discussion Ideally, this should do more checks.
#  */
valid_groupname()
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
 
    # Empty primary GID means "choose one for me"
    if [ "$NEWGID" = "" ] ; then
        return 0;
    fi
 
    local NEWGIDSTR="$(printf "%d" "$NEWGID" 2> /dev/null)"
 
    if [ "$NEWGIDSTR" != "$NEWGID" ] ; then
        return 1;
    fi
 
    return 0;
}
 
 
# /*!
#     @abstract Creates an associative pseudo-array for GID to username mapping.
#  */
initGIDMap()
{
    local SKIPGROUP="$1"
 
    # GROUPS is BASH reserved word
    local ALLGROUPS="$(dscl "$DOMAIN" -list /Groups)"
 
    for i in $ALLGROUPS ; do
        if [ "$i" != "$SKIPGROUP" ] ; then
            eval "GID_$(dscl "$DOMAIN" -read /Groups/"$i" PrimaryGroupID 2>/dev/null | sed 's/PrimaryGroupID: //' | sed 's/-/MINUS/')=\"$i\""
        fi
    done
}
 
 
# /*!
#     @abstract Looks up a GID in the pseudo-array and maps it to a group name
#  */
gidToName()
{
    local CHECKGID="$1"
 
    local CHECKGID_ENCODED="$(echo "$CHECKGID" | sed 's/-/MINUS/')"
 
 
    eval echo '$GID_'$CHECKGID_ENCODED
}
 
# /*!
#     @abstract Finds the next unused UID.
#  */
assignGID()
{
    initGIDMap
 
    # An error here means somebody screwed up MINGID.
    local POS=$MINGID
 
    while true ; do
        # echo "Trying $POS" 1>&2
        local TEMPNAME="$(gidToName $POS)"
        if [ "$TEMPNAME" = "" ] ; then
            echo $POS
            return;
        fi
        POS="$(expr $POS '+' 1)"
    done
}
 
# /*!
#     @abstract Returns success if no other group has the chosen GID.
#  */
gid_not_conflicting()
{
    local NEWGID="$1"
    local NEWGROUP="$2"
 
    initGIDMap "$NEWGROUP"
 
    local TEMPNAME="$(gidToName "$NEWGID")"
 
    if [ "$TEMPNAME" != "" ] ; then
        return 1;
    fi
 
    return 0
}
 
 
while ! valid_groupname "$GROUPNAME" ; do
    printf "Enter group name: "
    read GROUPNAME
done
 
while ! valid_gid  "$NEWGID" ; do
    printf "Invalid or no group ID specified.  Enter desired GID: "
    read NEWGID
done
 
while ! valid_longname "$LONGNAME" ; do
    printf "Invalid long name specified.  Enter desired long name: "
    read LONGNAME
done
 
 
# Test code
# echo "GID Conflict check:"
# gid_not_conflicting "80" "admin" # Test this first or else.
# echo "$? should be 0"
# gid_not_conflicting "80" "Schlomo"
# echo "$? should be 1"
 
echo "First free GID is $(assignGID)"
 
dscl $DOMAIN -read /Groups/"$GROUPNAME" > /dev/null 2>&1
if [ $? = 0 ] ; then
    echo "Failed.  A group with that name already exists.." 1>&2
    exit -1
fi
 
dscl $DOMAIN -create /Groups/"$GROUPNAME"
 
if [ $? != 0 ] ; then
    echo "Failed.  Group could not be created." 1>&2
    exit -1
fi
 
dscl $DOMAIN -create /Groups/"$GROUPNAME" RealName "$LONGNAME"
if [ "$NEWGID" = "" ] ; then
    NEWGID="$(assignGID)"
fi
dscl $DOMAIN -create /Groups/"$GROUPNAME" PrimaryGroupID $NEWGID
 
while ! gid_not_conflicting "$NEWGID" "$GROUPNAME"; do
    echo "A user with ID $NEWGID exists already.  Assigning a new GID." 1>&2
    OLDGID="$NEWGID"
    NEWGID="$(assignGID)"
    dscl $DOMAIN -change /Groups/"$GROUPNAME" PrimaryGroupID "$OLDGID" "$NEWGID"
done
 
UUID="$(/usr/bin/uuidgen)"
dscl $DOMAIN -create /Groups/"$GROUPNAME" GeneratedUID "$UUID";
 
# Legacy UNIX group password
dscl $DOMAIN -create /Groups/"$GROUPNAME" Password "*"
 
echo "Added $GROUPNAME with ID $NEWGID and UUID $UUID.  Please remember to set a password for the user."