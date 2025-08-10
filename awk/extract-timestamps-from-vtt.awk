#!/usr/bin/env awk -f

# This script processes a VTT file to extract start and end timestamps for sentences
# ending with a period, and outputs them to a CSV file.

# script usage
# awk -f extract-timestamps-from-vtt.awk input.vtt > cutlist.csv

# A BEGIN block is used to set the record and field separators.
# RS (Record Separator) is set to an empty string, which treats each blank-line-separated
# block of text in the VTT file as a single record.
# FS (Field Separator) is set to a newline character, so each line within a block
# is treated as a separate field ($1, $2, etc.).
BEGIN { RS = ""; FS = "\n" }

# A state variable to hold the start time of a sentence that spans multiple blocks.
# It is initialized to an empty string.
{
  # We first check if the first field ($1) contains the "-->" string, which indicates
  # a subtitle block with timestamps. We skip any non-subtitle blocks.
  if ($1 ~ /-->/) {
    # Extract the timestamp line and split it to get the start and end times of the block.
    split($1, times, " --> ")
    block_start_time = times[1]
    block_end_time = times[2]
    
    # Extract the text lines and join them into a single string.
    full_text = ""
    for (i = 2; i <= NF; i++) {
        full_text = full_text " " $i
    }
    
    # CRUCIAL FIX: Remove all ellipses (...) to avoid false sentence endings.
    gsub(/\.\.\./, "", full_text)

    # If this is the start of a new sentence, store the start time.
    if (start_time_of_sentence == "") {
      start_time_of_sentence = block_start_time
    }
    
    # Use a loop to handle sentences that might appear in the same subtitle block.
    while (match(full_text, /\./)) {
      # The sentence text is everything up to the first period.
      sentence_text = substr(full_text, 1, RSTART + RLENGTH - 1)
      
      # Since we don't have per-sentence timestamps within a block, the end time
      # of a sentence is the end time of the current block.
      end_time = block_end_time
      
      # Print the start and end times for the found sentence.
      print start_time_of_sentence "," end_time

      # Update the full_text buffer to remove the processed sentence.
      full_text = substr(full_text, RSTART + RLENGTH)
      
      # The next sentence starts where the last one ended.
      # The start time for the next sentence is the end time of the current block.
      start_time_of_sentence = block_end_time
    }
  }
}
