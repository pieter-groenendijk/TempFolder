# TemporaryFolders

A small but functional project to install functionality that automatically deletes files in specified locations on shutdown.

Should be compatible with almost every linux machine. Yet it's important to note that it hasn't been tested. It has only been tested on Fedora.

## Setting up / Updating the configuration

Want to set it up? or want to update it after doing some modifications?

1. Specify locations in the "config/locations" file. Every line will specify a folder. Only absolute paths are allowed.
2. (Optional) Specify targets (What events should trigger a cleanup) in the "config/targets" file. Every line should specify one target.
3. Run the install-script "scripts/install.sh". 
```bash
`sh ./scripts/install.sh`
```
<br>

You're officially done. If you want to change more specific advanced settings then go to "/config/settings". 

## Enabling and disabling

The functionality can be disabled/enabled by executing the respective scripts in the "scripts/" folder.

```bash
sh ./scripts/disable.sh
```
```bash
sh ./scripts/enable.sh
```
## Uninstalling

Currently, the uninstalling process hasn't been completed yet. However, this can be done by doing the following actions:

1. Running the "scripts/disable"