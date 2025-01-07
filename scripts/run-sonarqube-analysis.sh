#!/bin/bash

# Exit script on any error
set -e

# Read arguments
PROJECT_KEY=majid9971_latest-java
PROJECT_NAME=latest_java
BRANCH_NAME=main

# Verify SONAR_TOKEN is set
if [ -z "$SONAR_TOKEN" ]; then
  echo "Error: SONAR_TOKEN is not set. Ensure it is passed as an environment variable."
  exit 1
fi

# Run SonarQube analysis
echo "Running SonarQube analysis for project: $PROJECT_NAME"

mvn sonar:sonar \
  -Dsonar.projectKey="$PROJECT_KEY" \
  -Dsonar.projectName="$PROJECT_NAME" \
  -Dsonar.branch.name="$BRANCH_NAME" \
  -Dsonar.projectVersion=1.9 \
  -Dsonar.host.url=https://sonarcloud.io \
  -Dsonar.organization=majid9971 \
  -Dsonar.login="$SONAR_TOKEN"

echo "SonarQube analysis completed."

# Retrieve the task ID from the SonarQube scanner logs
TASK_ID=$(curl -s -u "$SONAR_TOKEN": "https://sonarcloud.io/api/project_analyses/search?project=$PROJECT_KEY&branch=$BRANCH_NAME" | jq -r '.[0].taskKey')

# Print task ID for debugging
echo "Task ID: $TASK_ID"

# If TASK_ID is empty, fail the script
if [ -z "$TASK_ID" ]; then
    echo "Error: Task ID not found, the analysis might not have completed successfully."
    exit 1
fi

# Wait for the analysis to finish (it can take a few seconds)
echo "Waiting for SonarQube analysis to finish..."
while true; do
    RESPONSE=$(curl -s -u "$SONAR_TOKEN": "https://sonarcloud.io/api/ce/task?id=$TASK_ID")
    STATUS=$(echo "$RESPONSE" | jq -r '.task.status')
    
    # Print the full response for debugging
    echo "Task status response: $RESPONSE"
    
    if [[ "$STATUS" == "SUCCESS" || "$STATUS" == "FAILED" ]]; then
        break
    fi
    echo "Analysis is still running, checking again..."
    sleep 10
done

# Get the quality gate status
QUALITY_GATE_STATUS=$(curl -s -u "$SONAR_TOKEN": "https://sonarcloud.io/api/qualitygates/project_status?projectKey=$PROJECT_KEY" | jq -r '.projectStatus.status')

# Print the quality gate status for debugging
echo "Quality Gate Status: $QUALITY_GATE_STATUS"

# Check if the quality gate passed or failed
if [ "$QUALITY_GATE_STATUS" != "OK" ]; then
    echo "Quality gate failed! The analysis has failed due to quality gate conditions."
    exit 1
else
    echo "Quality gate passed! The analysis is successful."
fi
