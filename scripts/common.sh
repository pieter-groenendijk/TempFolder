#!/bin/bash

readonly PROJECT_ROOT="$(dirname "${BASH_SOURCE}")/../"
readonly CONFIG_DIRECTORY="${PROJECT_ROOT}config/"
readonly SYSTEMD_DIRECOTRY="${PROJECT_ROOT}systemd/"



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

function isEmptyLine() {
    [[ -z "$1" ]]
}

function isCommentLine() {
    [[ "${1:0:1}" == "#" ]]
}