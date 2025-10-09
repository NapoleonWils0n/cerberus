# Purpose: Concatenates all Markdown files in the current directory (excluding the Makefile itself)
# and cleans up inherited formatting errors (like mangled bold text) using shell tools,
# producing a clean, ready-to-use combined Markdown document.
#
# Tools used: fd, xargs, awk, printf

# Define the name of the final output file
OUTPUT_FILE = combined_document.md

.PHONY: $(OUTPUT_FILE) all clean

all: $(OUTPUT_FILE)

# FINAL SOLUTION: Uses your exact FD command and AWK logic, adding a cleanup step for malformed bolding.
# Fixes the 'unexpected EOF' error by consolidating the AWK/printf into a single, correctly quoted line.
$(OUTPUT_FILE):
	@rm -f "$@" 
	@fd -t f -e md -d 1 --exclude "$@" -0 | xargs -0 -I {} sh -c 'awk "{gsub(/\\*{5,}/, \"**\"); print}" "{}" && printf "\n\n"' > "$@"

clean:
	@rm -f $(OUTPUT_FILE)
