#!/bin/bash

# Thresholds for each partition
ROOT_THRESHOLD=90
DATA_THRESHOLD=80
LOG_THRESHOLD=85

# Email settings
TO_EMAIL="admin@example.com"
SUBJECT_WARNING="Disk Space Alert!"
SUBJECT_REPORT="Daily Disk Space Report"
EMAIL_BODY_WARNING="/tmp/disk_space_warning.txt"
EMAIL_BODY_REPORT="/tmp/disk_space_report.txt"
LOG_FILE="/var/log/disk_space_report.log"

# Get current date for the report
CURRENT_DATE=$(date +"%Y-%m-%d")

# Initialize warning message flag
WARNINGS=false

# Create the report header
echo "Disk Usage Report - $CURRENT_DATE" >$EMAIL_BODY_REPORT
echo "----------------------------------" >>$EMAIL_BODY_REPORT
df -h >>$EMAIL_BODY_REPORT

# Function to check a specific partition
check_partition() {
    PARTITION=$1
    THRESHOLD=$2
    USAGE=$(df -h | grep "$PARTITION" | awk '{print $5}' | sed 's/%//')

    if [ "$USAGE" -gt "$THRESHOLD" ]; then
        echo "Warning: $PARTITION is ${USAGE}% full, exceeding threshold of ${THRESHOLD}%!" >>$EMAIL_BODY_WARNING
        WARNINGS=true
    fi
}

# Check each partition with specific thresholds
check_partition "/" $ROOT_THRESHOLD
check_partition "/data" $DATA_THRESHOLD
check_partition "/var/log" $LOG_THRESHOLD

# Send warning email if any partition exceeded its threshold
if [ "$WARNINGS" = true ]; then
    mail -s "$SUBJECT_WARNING" "$TO_EMAIL" <$EMAIL_BODY_WARNING
fi

# Send the daily disk report
mail -s "$SUBJECT_REPORT - $CURRENT_DATE" "$TO_EMAIL" <$EMAIL_BODY_REPORT

# Append the daily report to the log file
cat $EMAIL_BODY_REPORT >>$LOG_FILE

# Optional: Log rotation to prevent large logs (keep logs for 30 days)
find /var/log/disk_space_report.log* -mtime +30 -exec rm {} \;

# Clean up temporary files
rm -f $EMAIL_BODY_WARNING $EMAIL_BODY_REPORT
