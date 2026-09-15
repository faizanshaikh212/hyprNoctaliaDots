# ⚙️ My Dotfiles

Welcome to my personal dotfiles repository! This setup manages my system environment configurations and tools cleanly using **chezmoi**. Though you can just use the default `install.sh` script to install the dotfiles or just copy and paste as you please.

But be careful of breaking your system, please review everything before using any dotfiles.

The `install.sh` script safely deploys configurations into `~/.config` while protecting your existing environment with automatic backups.

The `install_c.sh` script does the same, but it also initializes 'chezmoi' which is helpful for dotfiles management.

Use respective restore script to restore your old config files, `restore.sh` if you installed using `install.sh` and use `restore_c.sh` if you used `install_c.sh` script to install the dotfiles.

Follow the Quick Start Guide for more info.

---

## NOTE BEFORE INSTALLATION:
If you system breaks its not my fault, please review the dotfiles, and only install/copy-paste them if you know what you are doing, as hyprland is a bleeding edge package, if there is a version mismatch betweek dotfiles and your system, things will not work as intended,
Also just in case you are copy and pasting the dotfiles, remember to `chmod +x` every script included, and also rename the scripts by removing the `executable_` prefix in them, as its related to chezmoi install, and won't work if you copy paste.

---

## 🚀 Quick Start (Installation)

Clone the repo and try out my dotfiles :)

### 1. Clone git repo
Run the following commands in your terminal:

```bash
git clone https://github.com/faiz-n-shk/.hypr-dots.git
cd .hypr-dots
```

### 2. Choose and option to install the dotfiles

`./install.sh` - to run the installation script that just copies and pastes dotfiles into your config directory while creating a backup.
`./install_c.sh` - to run the installation script that initializes chezmoi and installs dotfiles with a backup.

---

## 🔄 How to Revert (Uninstall)

If you want to remove my configurations and restore your original machine state exactly the way it was before, simply run the restore script from inside the repository directory:

`./restore.sh` - to restore the installation done by `install.sh`.
`./restore_c.sh` - to restore the installation done by `install_c.sh`.

---

## 🛠️ Repository Structure

* `dot_config/` — Contains all configuration files.
* `install.sh` — The automated default installation script.
* `install_c.sh` — The automated script to install dotfiles with a chezmoi initialization.
* `restore.sh` — The one-click uninstaller script for default installation.
* `restore_c.sh` — The one-click uninstaller script for installation of dotfiles with install_c.sh.

---

## 📝 License
This project is open-source. Feel free to fork it, modify it, and make it your own :)
