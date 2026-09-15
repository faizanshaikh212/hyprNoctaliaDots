# Greeting & Prompt Setup
# ------------------------------------------
function fish_greeting
    # Displays system info, hardware specs, and OS logo as a startup banner
end

# Environment Variables
# ------------------------------------------
# Forces man pages to render cleanly with proper formatting codes
set -x MANROFFOPT "-c"
# Replaces standard man page viewer with 'bat', adding syntax highlighting and colors
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Sets the 'done' plugin to notify only if a background command takes longer than 10 seconds
set -U __done_min_cmd_duration 10000 
# Sets desktop notification pop-up importance to low
set -U __done_notification_urgency_level low

# Loads custom environment variables and shell settings from ~/.fish_profile if it exists
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Adds personal script folders and developer tools permanently to your system search path
fish_add_path ~/.local/bin ~/.cargo/bin ~/Applications/depot_tools


# Key Bindings & History (Bash-style `!!` and `!$`)
# ------------------------------------------
function __history_previous_command
    switch (commandline -t)
        case "!"
            # Replaces '!' with your exact previous command and executes/repaints it
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            # Cycles backward through the arguments of your previous commands
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
        end
end

# Binds the exclamation and dollar keys to recall past commands based on your active keyboard mode
if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end


# Custom Functions
# ------------------------------------------
# Prints your command history list formatted with exact calendar dates and timestamps
function history
    builtin history --show-time='%F %T ' $argv
end

# Creates an immediate exact duplicate copy of a file with a '.bak' extension attached to the end
function backup --argument filename
    cp $filename $filename.bak
end

# Copies files or whole folders recursively without forcing you to manually type flags like -r
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (string trim -r -c / $argv[1])
        command cp -r $from $argv[2]
    else
        command cp $argv
    end
end


# =============================
# Yazi File Manager Integration
# =============================
function y
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end

# ====================================
# Smart Directory Navigation Functions
# ====================================
# Downloads
function dl;  if test (count $argv) -gt 0; cd ~/Downloads/$argv[1]; else; cd ~/Downloads; end; end
function ydl; if test (count $argv) -gt 0; y ~/Downloads/$argv[1]; else; y ~/Downloads; end; end

# Config
function conf;  if test (count $argv) -gt 0; cd ~/.config/$argv[1]; else; cd ~/.config; end; end
function yconf; if test (count $argv) -gt 0; y ~/.config/$argv[1]; else; y ~/.config; end; end

# Documents
function docs;  if test (count $argv) -gt 0; cd ~/Documents/$argv[1]; else; cd ~/Documents; end; end
function ydocs; if test (count $argv) -gt 0; y ~/Documents/$argv[1]; else; y ~/Documents; end; end

# Desktop
function desk;  if test (count $argv) -gt 0; cd ~/Desktop/$argv[1]; else; cd ~/Desktop; end; end
function ydesk; if test (count $argv) -gt 0; y ~/Desktop/$argv[1]; else; y ~/Desktop; end; end

# Games
function games;  if test (count $argv) -gt 0; cd ~/Games/$argv[1]; else; cd ~/Games; end; end
function ygames; if test (count $argv) -gt 0; y ~/Games/$argv[1]; else; y ~/Games; end; end

# Pictures
function pics;  if test (count $argv) -gt 0; cd ~/Pictures/$argv[1]; else; cd ~/Pictures; end; end
function ypics; if test (count $argv) -gt 0; y ~/Pictures/$argv[1]; else; y ~/Pictures; end; end

# Music
function music;  if test (count $argv) -gt 0; cd ~/Music/$argv[1]; else; cd ~/Music; end; end
function ymusic; if test (count $argv) -gt 0; y ~/Music/$argv[1]; else; y ~/Music; end; end

# Useful Aliases
# ------------------------------------------
# Replaces standard folder listing with 'eza' (showing icons, colors, and sorting directories first)
alias ls='eza -al --color=always --group-directories-first --icons=always' # Lists every file and folder in detail (including hidden ones)
alias la='eza -a --color=always --group-directories-first --icons=always'  # Lists all files and folders in a grid layout (including hidden ones)
alias ll='eza -l --color=always --group-directories-first --icons=always'  # Lists only standard files and folders in detail (hiding hidden items)
alias lt='eza -aT --color=always --group-directories-first --icons=always' # Displays an indented visual tree structure of all files and folders
alias l.="eza -a | grep -e '^\.'"                                          # Filters out everything except hidden files and directories starting with a dot

# Arch Linux / CachyOS System Maintenance
alias update='sudo cachyos-rate-mirrors && sudo pacman -Syu'  # Tests download speeds, selects fastest global mirrors, and updates all system packages
alias mirror="sudo cachyos-rate-mirrors"                      # Refreshes and optimizes your package mirror server ranking list based on speed
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"      # Re-scans your storage drives and rebuilds your computer's bootloader menu configuration
alias fixpacman="sudo rm /var/lib/pacman/db.lck"              # Force-deletes the package manager lock file if pacman crashed or froze mid-update
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'               # Automatically sweeps your system and removes leftover "orphan" packages no longer needed
alias jctl="journalctl -p 3 -xb"                              # Opens critical system boot logs filtered specifically to show errors and hardware crashes

# Utilities & Shortcuts
alias tarnow='tar -acf '                                      # Compresses selected files or folders into a new `.tar.gz` archive bundle
alias untar='tar -zxvf '                                      # Extracts compressed contents out of a `.tar.gz` archive package
alias wget='wget -c '                                         # Downloads a file from the web with auto-resume support if your internet drops
alias psmem='ps auxf | sort -nr -k 4'                         # Prints a live sorted list of all active background programs ranked by memory usage
alias psmem10='ps auxf | sort -nr -k 4 | head -10'            # Isolates and shows strictly the top 10 heaviest memory-consuming processes
alias hw='hwinfo --short'                                     # Generates a quick, concise summary of your computer's installed physical hardware
alias big="expac -H M '%m\t%n' | sort -h | nl"                # Scans all installed system packages and lists them out sorted by size in megabytes
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" # Pulls a chronological history log of your 200 most recently installed applications
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'            # Counts and outputs the exact total number of development/git packages installed on your system

# Navigation shortcuts
alias ..='cd ..'       # Instantly moves you back up one parent directory level
alias ...='cd ../..'   # Jumps back up two directory levels at once
alias ....='cd ../../..' # Jumps back up three directory levels
alias .....='cd ../../../..' # Jumps back up four directory levels
alias ......='cd ../../../../..' # Jumps back up five directory levels

# Humor / Newcomer helpers
alias apt='man pacman'        # Redirects Debian users typing 'apt' to read the Arch Linux package manager manual instead
alias apt-get='man pacman'    # Redirects Debian users typing 'apt-get' to read the Arch pacman manual instead
alias tb='nc termbin.com 9999' # Uploads text or command outputs straight to the cloud and returns a shareable text-bin link
