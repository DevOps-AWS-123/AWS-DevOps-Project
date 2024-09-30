#!/bin/bash

###Debugging purpose
set -x
###particular word or string
cut -d ' ' -f 3

######particular word or string
awk -F " " '{print $1}'

###$? exit codes
###$@ multiple paramters
####$1, $2 is params for single
###$* this is also as $@ This
###Command	    Use Case	                        Example
##awk	        Complex field-based processing	   Calculate sums, conditionally process columns
##cut	Simple extraction of columns or characters	Extract fields from CSV or fixed-width data
##sed	Search/replace, delete, and text transformation	Perform in-place edits, remove specific lines

##awk awk 'pattern {action}' file
##cut cut -d'delimiter' -f field_number file
##sed sed 's/pattern/replacement/' file
##find [path] [executable]
find . -name "file.txt"                              # Find a file named "file.txt"
find . -iname "file.txt"                             # Find a file named "file.txt" (case-insensitive)
find . -type f                                       # Find all regular files
find . -type d                                       # Find all directories
find . -size +100M                                   # Find files larger than 100MB
find . -mtime +7                                     # Find files modified more than 7 days ago
find . -atime -2                                     # Find files accessed in the last 2 days
find . -ctime +3                                     # Find files with status changed more than 3 days ago
find . -type f -name "*.txt" -exec cat {} \;         # Display content of each .txt file found
find . -type f -name "*.tmp" -delete                 # Delete all .tmp files
find . -type f -name "*.jpg" -print                  # Print names of all .jpg files found
find . -user username                                # Find files owned by a specific user
find . -group groupname                              # Find files owned by a specific group
find . -perm 644                                     # Find files with permissions set to 644
find . -name "*.log" -mtime -7 -delete               # Find and delete .log files modified in the last 7 days
find . -type f -size +1G -exec du -h {} \;           # Find files larger than 1GB and display their sizes
find . -name "*.bak" -exec mv {} /path/to/backup/ \; # Move .bak files to a backup directory
find . -type d -empty                                # Find all empty directories
find . -type f -exec grep -l "error" {} \;           # Find files containing the word "error"
find . -mmin -30                                     # Find files modified in the last 30 minutes
