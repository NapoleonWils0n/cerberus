#!/bin/sh
 
# Get an absolute path for the poem.txt file.
POEM="$PWD/../poem.txt"
 
# Get an absolute path for the script file.
SCRIPT="$(which $0)"
if [ "x$(echo $SCRIPT | grep '^\/')" = "x" ] ; then
    SCRIPT="$PWD/$SCRIPT"
fi
 
# Launch TextEdit and open both the poem and script files.
cat << EOF | osascript -l AppleScript > /dev/null
launch application "TextEdit"
tell application "TextEdit"
    open "$POEM"
end tell
 
set myDocument to result
return number of myDocument
EOF
 
cat << EOF | osascript -l AppleScript > /dev/null
launch application "TextEdit"
tell application "TextEdit"
        open "$SCRIPT"
end tell
 
set myDocument to result
return number of myDocument
EOF
 
 
# Tell the shell not to mangle newline characters, tabs, or whitespace.
IFS=""
 
# Ask TextEdit for a list of open documents.  From this, we can
# obtain a document number that corresponds with the poem.txt file.
# This query returns a newline-deliminted list of open files. Each
# line contains the file number, followed by a tab, followed by the
# filename
DOCUMENTS="$(cat << EOF | osascript -l AppleScript
 
    tell application "TextEdit"
        documents
    end tell
 
    set myList to result         -- Store the result of "documents" message into variable "myList"
    set myCount to count myList  -- Store the number of items in myList into myCount
    set myRet to ""              -- Create an empty string variable called "myRet"
 
    (* Loop through the myList array and build up a string in the myRet variable
       containing one line per entry in the form:
 
        number tab_character name
      *)
    repeat with myPos from 1 to myCount
        set myRet to myRet & myPos & "\t" & name of item myPos of myList & "\n"
    end repeat
    return myRet
EOF
)"
 
# Determine the document number that corresponds with the poem.txt
# file.
DOCNUMBER="$(echo $DOCUMENTS | grep '[[:space:]]poem\.txt' | grep -v ' poem\.txt' | head -n 1 | sed 's/\([0-9][0-9]*.\).*/\1/')"
SECOND_DOCNUMBER="$(echo $DOCUMENTS | grep '[[:space:]]poem\.txt' | grep -v ' poem\.txt' | tail -n 1 | sed 's/\([0-9][0-9]*.\).*/\1/')"
 
if [ $DOCNUMBER -ne $SECOND_DOCNUMBER ] ; then
    echo "WARNING: You have more than one file named poem.txt open.  Using the" 1>&2
    echo "most recently opened file." 1>&2
    echo "DOCNUMBER $DOCNUMBER != $SECOND_DOCNUMBER"
fi
 
echo "DOCNUMBER: $DOCNUMBER"
 
if [ "x$DOCNUMBER" != "x" ] ; then
    # Query poem.txt by number
    FIRSTPARAGRAPH="$(cat << EOF | osascript -l AppleScript
        tell application "TextEdit"
            paragraph 1 of document $DOCNUMBER
        end tell
EOF
    )"
    echo "The first paragraph of poem.txt is:"
    echo "$FIRSTPARAGRAPH"
fi
 
# Query poem.txt by name
FIRSTPARAGRAPH="$(cat << EOF | osascript -l AppleScript
        tell application "TextEdit"
            paragraph 1 of document "poem.txt"
        end tell
EOF
)"
echo "The first paragraph of poem.txt is:"
echo "$FIRSTPARAGRAPH"