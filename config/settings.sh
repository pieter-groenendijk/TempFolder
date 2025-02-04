if [[ -z "$SETTINGS_LOADED" ]]; then
    # This file contains miscealleneous settings.
    #
    #
    # MinimumNestingLevel:
    #   The minimum number of nested directories for a path to be accepted.
    #   So, the path: "/home/user/Documents/Projects/" has a nesting level of 5 (Basically every forward slash)
    readonly MINIMUM_NESTING_LEVEL=4
    # MaxSize:
    #   The maximum allowed size of an directory that is permitted to be deleted.
    #   Specified in KiB
    readonly MAX_SIZE=10485760
    # SystemdServicesFolderPath
    #
    #
    readonly SERVICES_DIRECTORY=/etc/systemd/system



    readonly SETTINGS_LOADED=true
fi
