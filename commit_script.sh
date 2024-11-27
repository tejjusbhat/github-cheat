#!/bin/bash

# Start date from 30 weeks ago
START_DATE=$(date -d "30 weeks ago" +%Y-%m-%d)

# Loop for 150 commits
commit_count=0
current_date="$START_DATE"

while [ $commit_count -lt 150 ]; do
    # Check if the current date is a weekday (1=Monday, 5=Friday)
    day_of_week=$(date -d "$current_date" +%u)
    if [ "$day_of_week" -lt 6 ]; then
        # Generate commit date and message for weekdays
        COMMIT_DATE=$(date -d "$current_date" +"%Y-%m-%dT10:00:00")
        GIT_COMMITTER_DATE="$COMMIT_DATE" git commit --allow-empty -m "Weekday commit for $COMMIT_DATE" --date "$COMMIT_DATE"
        commit_count=$((commit_count + 1))
    fi
    
    # Move to the next day
    current_date=$(date -d "$current_date +1 day" +%Y-%m-%d)
done
