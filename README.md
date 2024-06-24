# TemporaryFolders

A small but functional project to install functionality that automatically deletes files in specified locations on shutdown.


## Setting up / Updating the configuration

Below instructions although numbered, can be executed in any order. Some steps are optional, if left out these will revert to the standard values in those configuration files.

1. Specify locations in the "/config/locations" file. Every line will specify a folder. Only absolute paths are allowed.
2. (Optional) Specify targets (What events should trigger a cleanup) in the "config/targets" file. Every line should specify one target.
3. Run the install-script "/src/install.sh".