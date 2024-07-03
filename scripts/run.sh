#!/bin/bash

readonly PROJECT_ROOT="$(dirname "${BASH_SOURCE}")/../";
readonly CONFIG_DIRECTORY="${PROJECT_ROOT}config/"
readonly LOCATIONS_CONFIGURATION_FILE="${CONFIG_DIRECTORY}locations.conf"

# Load settings
source "${CONFIG_DIRECTORY}settings.conf"

# Functions
function log() {
    local message="$1";

    local logFilePath="${PROJECT_ROOT}logs/logs.log"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    echo "[${timestamp}] $message" >> "$logFilePath"
}

function exitIfFileNotReadable() {
    local filePath="$1"

    if [ ! -r "${filePath}" ]; then
        log "Error: file is not readable \"${filePath}\""
        exit 1
    fi
}

function trimWhitespace() {
    local value="$1"

    value="${1#"${1%%[![:space:]]*}"}"
    value="${1%"${1##*[![:space:]]}"}"

    echo "$value"
}

function countPatternMatches() {
    local needle="$1"
    local haystack="$2"

    if [ -z "$needle" ]; then
        return 1
    fi

    echo "$haystack" | grep -o "$needle" | wc -l
}

function isEmptyLine() {
    [[ -z "$1" ]]
}

function isCommentLine() {
    [[ "${1:0:1}" == "#" ]]
}

function minimumNestingLevel() {
    countPatternMatches "/" "$1"
}

function failsMinimumNestingLevel() {
    [[ $(minimumNestingLevel "$1") -lt $MINIMUM_NESTING_LEVEL ]]
}

function size() {
    local path="$1"

    du --summarize "$path" | cut --fields=1
}

function exceedsMaximumSize() {
    local path="$1"

    [[ $(size "$path") -gt $MAX_SIZE ]]
}

function removeContentOfDirectory() {
    local path="$1"

    rm -r "${path}"*
}


# Main application code
exitIfFileNotReadable "$LOCATIONS_CONFIGURATION_FILE"

while IFS= read -r line; do
    line=$(trimWhitespace "$line")

    if isEmptyLine "$line" || isCommentLine "$line"; then
        continue
    fi

    # Following conditions should log a warning or error
    if failsMinimumNestingLevel "$line"; then
        log "ABORTING | Fails minimum nesting level check: $line"
        continue;
    fi
    if exceedsMaximumSize "$line"; then
        log "ABORTING | Fails maximum size check: $line"
        continue;
    fi

    echo "passed checks: $line"

    removeContentOfDirectory "$line"
done < "$LOCATIONS_CONFIGURATION_FILE"

