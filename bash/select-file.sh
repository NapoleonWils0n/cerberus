#!/bin/sh
# Displays a list of files in current directory and prompt for which
# file to edit

echo “#=========================================#”;
echo “# Select a file to edit #”;
echo “#=========================================#”;

# Set the prompt for the select command
PS3="Type a number or 'q' to quit: "

# Create a list of files to display
fileList=$(find . -maxdepth 1 -type f)

# Show a menu and ask for input. If the user entered a valid choice,
# then invoke the editor on that file
select fileName in $fileList; do
	if [ -n "$fileName" ]; then
		/usr/bin/mate ${fileName}
	fi
	break
done