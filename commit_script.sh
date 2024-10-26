#!/bin/bash

# Start date from 30 weeks ago
START_DATE=$(date -d "30 weeks ago" +%Y-%m-%d)

# Loop for 150 commits over weekdays, skipping weekends
commit_count=0
current_date="$START_DATE"

while [ $commit_count -lt 150 ]; do
    # Get the day of the week (1=Monday, ..., 7=Sunday)
    day_of_week=$(date -d "$current_date" +%u)
    
    # Check if it's a weekday (1 to 5)
    if [[ $day_of_week -lt 6 ]]; then
        # Primary commit
        COMMIT_DATE=$(date -d "$current_date" +"%Y-%m-%dT14:00:00")
        GIT_COMMITTER_DATE="$COMMIT_DATE" git commit --allow-empty -m "Commit for $COMMIT_DATE" --date "$COMMIT_DATE"
        
        # If it's Wednesday (3) or Friday (5), make a second commit
        if [[ $day_of_week -eq 3 || $day_of_week -eq 5 ]]; then
            SECOND_COMMIT_DATE=$(date -d "$current_date +1 hour" +"%Y-%m-%dT15:00:00")
            GIT_COMMITTER_DATE="$SECOND_COMMIT_DATE" git commit --allow-empty -m "Second commit for $SECOND_COMMIT_DATE" --date "$SECOND_COMMIT_DATE"
        fi
        
        # Increment commit count for each weekday
        commit_count=$((commit_count + 1))
    fi
    
    # Move to the next day
    current_date=$(date -d "$current_date +1 day" +%Y-%m-%d)
done
