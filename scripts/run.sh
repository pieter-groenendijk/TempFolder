#!/bin/bash

SCRIPTS_DIRECTORY=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source "${SCRIPTS_DIRECTORY}/common.sh"
source "${CONFIG_DIRECTORY}/settings.sh"

readonly LOCATIONS_CONFIGURATION_FILE="${CONFIG_DIRECTORY}/locations.conf"


function minimumNestingLevel() {
    patternMatchesAmount "/" "$1"
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

    if isEmpty "$line" || isComment "$line"; then
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

