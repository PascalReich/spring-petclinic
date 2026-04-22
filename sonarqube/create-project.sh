#!/usr/bin/env bash

set -euo pipefail

SONAR_URL="${SONAR_URL:-http://localhost:9000}"
SONAR_USER="${SONAR_USER:-admin}"
SONAR_PASSWORD="${SONAR_PASSWORD:-admin}"
SONAR_PROJECT_KEY="${SONAR_PROJECT_KEY:-spring-petclinic}"
SONAR_PROJECT_NAME="${SONAR_PROJECT_NAME:-spring-petclinic}"
SONAR_TOKEN_NAME="${SONAR_TOKEN_NAME:-jenkins-sonar}"
ENV_FILE="${ENV_FILE:-.env}"

curl -u "${SONAR_USER}:${SONAR_PASSWORD}" \
  -X POST \
  "${SONAR_URL}/api/projects/create?name=${SONAR_PROJECT_NAME}&project=${SONAR_PROJECT_KEY}" || true

token_response="$(
  curl -s -u "${SONAR_USER}:${SONAR_PASSWORD}" \
    -X POST \
    "${SONAR_URL}/api/user_tokens/generate?name=${SONAR_TOKEN_NAME}"
)"

token_field="$(
  printf '%s' "${token_response}" |
    tr ',' '\n' |
    grep '"token":"'
)"

SONAR_TOKEN="$(
  printf '%s' "${token_field}" |
    cut -d ':' -f 2 |
    tr -d '"'
)"

if [ -z "${SONAR_TOKEN}" ]; then
  echo "Failed to generate SonarQube token." >&2
  exit 1
fi

if [ -f "${ENV_FILE}" ] && grep -q '^SONAR_TOKEN=' "${ENV_FILE}"; then
  sed -i "s/^SONAR_TOKEN=.*/SONAR_TOKEN=${SONAR_TOKEN}/" "${ENV_FILE}"
else
  printf '\nSONAR_TOKEN=%s\n' "${SONAR_TOKEN}" >> "${ENV_FILE}"
fi

echo "Project '${SONAR_PROJECT_KEY}' is ready."
echo "SONAR_TOKEN saved to ${ENV_FILE}."
