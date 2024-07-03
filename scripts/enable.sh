#!/bin/bash

SCRIPTS_DIRECTORY=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source "${SCRIPTS_DIRECTORY}/service-utilities.sh"

enableService
