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

# Run SonarQube analysis
mvn sonar:sonar \
  -Dsonar.projectKey="$PROJECT_KEY" \
  -Dsonar.projectName="$PROJECT_NAME" \
  -Dsonar.branch.name="$BRANCH_NAME" \
  -Dsonar.projectVersion=1.9 \
  -Dsonar.host.url=https://sonarcloud.io \
  -Dsonar.organization=majid9971 \
  -Dsonar.login="$SONAR_TOKEN"

echo "SonarQube analysis completed."

# Get the task ID for the analysis report
TASK_ID=$(curl -s -u "$SONAR_TOKEN": "https://sonarcloud.io/api/ce/task?id=$PROJECT_KEY" | jq -r '.task.id')

# Wait for the analysis to finish
echo "Waiting for SonarQube analysis to finish..."
while true; do
  # Check the status of the analysis task
  RESPONSE=$(curl -s -u "$SONAR_TOKEN": "https://sonarcloud.io/api/ce/task?id=$TASK_ID")
  echo "Task status response: $RESPONSE"  # Debugging line

  # Check the status of the task
  TASK_STATUS=$(echo "$RESPONSE" | jq -r '.task.status')

  # If the task is finished, break out of the loop
  if [ "$TASK_STATUS" == "FINISHED" ]; then
    break
  fi

  # Wait for 10 seconds before checking again
  sleep 10
done

# Fetch the quality gate status after task finishes
QUALITY_GATE_STATUS=$(curl -s -u "$SONAR_TOKEN": "https://sonarcloud.io/api/qualitygates/project_status?projectKey=$PROJECT_KEY")

# Print the full response to see the structure of the JSON data for debugging
echo "Quality Gate Status response: $QUALITY_GATE_STATUS"  # Debugging line

# Check the quality gate status
QUALITY_GATE_RESULT=$(echo "$QUALITY_GATE_STATUS" | jq -r '.projectStatus.status')

# If the quality gate failed, print the failure message and exit with an error code
if [ "$QUALITY_GATE_RESULT" != "OK" ]; then
  echo "Quality Gate failed. Project did not pass the quality gate."
  exit 1
else
  echo "Quality Gate passed. Project passed the quality gate."
fi
