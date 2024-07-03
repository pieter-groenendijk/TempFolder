#!/bin/bash

if [[ -z "$COMMON_LOADED" ]]; then

    readonly PROJECT_ROOT="$(realpath "$(dirname "$(realpath "$0")")/../")"
    readonly CONFIG_DIRECTORY="${PROJECT_ROOT}/config"
    readonly TEMPLATE_DIRECTORY="${PROJECT_ROOT}/templates"


    function log() {
        local message="$1";

        local logFilePath="${PROJECT_ROOT}/logs/logs.log"
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

    function isEmpty() {
        [[ -z "$1" ]]
    }

    function isComment() {
        [[ "${1:0:1}" == "#" ]]
    }

    function patternMatchesAmount() {
        local needle="$1"
        local haystack="$2"

        if [ -z "$needle" ]; then
            return 1
        fi

        echo "$haystack" | grep -o "$needle" | wc -l
    }

    function containsPattern() {
        local needle="$1"
        local haystack="$2"

        echo "$haystack" | grep --quiet "$needle"
    }

    COMMON_LOADED=true
fi