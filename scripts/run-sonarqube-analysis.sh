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
  -Dsonar.host.url=https://sonarcloud.io \
  -Dsonar.organization=majid9971 \
  -Dsonar.login="$SONAR_TOKEN"

echo "SonarQube analysis completed."
