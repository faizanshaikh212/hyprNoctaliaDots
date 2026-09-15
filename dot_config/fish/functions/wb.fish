function wb --description 'Shortcuts to web url links'
    # List of shortcuts for the help menu
    set -l shortcuts "whatsapp (-wha), archwiki (-archw), hyprwiki (-hyprw), waybarwiki (-waybarw), github (-git), youtube (-yt)"

    # Trigger help display if no args, too many args, or help flags are passed
    if test (count $argv) -eq 0; or test "$argv[1]" = -h; or test "$argv[1]" = --help
        echo "Usage: wb [shortcut]"
        echo "Available shortcuts: $shortcuts"
        return 0
    end

    # Variable to hold target URL
    set -l url ""

    # Check only the first argument entered
    switch $argv[1]
        case archwiki -archw
            set url "https://wiki.archlinux.org"

        case hyprlandwiki hyprwiki -hyprw
            set url "https://wiki.hypr.land"

        case waybarwiki wbwiki -waybarw -wbw
            set url "https://github.com/Alexays/Waybar/wiki"

        case github git -git -gh
            set url "https://github.com/faiz-n-shk"

        case youtube yt -yt
            set url "https://youtube.com"

        case whatsapp what wha -what -wha
            set url "https://web.whatsapp.com"
        case '*'
            echo "Error: Unknown shortcut '$argv[1]'"
            echo "Available shortcuts: $shortcuts"
            return 1
    end

    # Open browser detached from terminal
    nohup xdg-open "$url" </dev/null >/dev/null 2>&1 &

    # Safely detach the background job in Fish
    disown

    # Small delay to let xdg-open hand off the process to the browser
    sleep 0.1

    # Cleanly exit the terminal window
    exit
end
