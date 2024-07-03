#!/bin/bash

SCRIPTS_DIRECTORY=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source "${SCRIPTS_DIRECTORY}/common.sh"
source "${CONFIG_DIRECTORY}/settings.sh"

readonly SERVICE_NAME="temp-folder.service"

function enableService() {
    sudo systemctl enable $SERVICE_NAME
}

function disableService() {
    sudo systemctl disable $SERVICE_NAME
}

function reloadService() {
    sudo systemctl daemon-reload
    disableService
    enableService
}

function newServiceFile() {
    local newFile="$1"

    echo "$newFile" | sudo tee "${SERVICES_DIRECTORY}/${SERVICE_NAME}" > /dev/null
    reloadService
}