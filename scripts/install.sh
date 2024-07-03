#!/bin/bash

source ./common.sh
source "${CONFIG_DIRECTORY}settings.conf"

readonly SERVICE_NAME="temp-folder.service"

function targetName() {
    echo "${1}.service"
}

function targets() {
    local targetConfigurationFile="${PROJECT_ROOT}config/targets.conf"
    local targets=""

    while IFS= read -r line; do
        line=$(trimWhitespace "$line")

        if isEmpty "$line" || isComment "$line"; then
            continue
        fi

        if ! containsPattern ".target$" "$line"; then
            line="${line}.target"
        fi

        targets="${targets}${line} "
    done < "$targetConfigurationFile"

    echo "$targets"
}

# Not optimal since it replaces every placeholder separately
function replacePlaceholder() {
    local placeholder="$1"
    local replacement="$2"
    local string="$3"

    echo "${string//${placeholder}/${replacement}}"
}

function writeNewServiceUnitFile() {
    local newFile="$1"

    echo "$newFile" | sudo tee "${SERVICES_DIRECTORY}${SERVICE_NAME}" > /dev/null
}

function activateServiceUnitFile() {
    sudo systemctl daemon-reload
    sudo systemctl disable "$1"
    sudo systemctl enable "$1"
}

function createServiceUnitFile() {
    local targets="$(targets)"
    local template=$(cat "${TEMPLATE_DIRECTORY}${SERVICE_NAME}")

    template=$(replacePlaceholder "{{PROJECT_ROOT}}" "$PROJECT_ROOT" "$template")
    template=$(replacePlaceholder "{{TARGETS}}" "$targets" "$template")

    writeNewServiceUnitFile "$template"
    activateServiceUnitFile "$SERVICE_NAME"
}

createServiceUnitFile






