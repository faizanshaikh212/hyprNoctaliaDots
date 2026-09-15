function neo --description 'Dynamic dotfile editor shortcut'
    # Clean, scannable shortcuts list
    set -l shortcuts "btop, cava, fastfetch, fish, hypr, kitty, nvim, rofi, swaync, waybar, yazi"

    # Trigger help display if no args, too many args, or help flags are passed
    if test (count $argv) -eq 0; or test "$argv" = -h; or test "$argv" = --help
        echo "Usage: neo [shortcut]"
        echo "Available shortcuts: $shortcuts"
        return 0
    end

    # Define the base configuration directory
    set -l config_dir ~/.config
    set -l sub_dir ""

    # Switch case to determine only the subfolder name
    switch $argv
        case config.btop btop -btop
            set sub_dir btop

        case config.cava cava -cava
            set sub_dir cava

        case config.fastfetch fastfetch fetch -fastfetch -fetch
            set sub_dir fastfetch

        case config.fish fish -fish
            set sub_dir fish

        case config.hypr hypr -hypr
            set sub_dir hypr

        case config.kitty kitty -kitty
            set sub_dir kitty

        case config.nvim neovim nvim -neovim -nvim
            set sub_dir nvim

        case config.rofi rofi -rofi
            set sub_dir rofi

        case config.swaync swaync -swaync
            set sub_dir swaync

        case config.waybar waybar -waybar
            set sub_dir waybar

        case config.yazi yazi -yazi
            set sub_dir yazi

        case '*'
            echo "Error: Unknown shortcut '$argv'"
            echo "Available shortcuts: $shortcuts"
            return 1
    end

    # Combine them safely and open Neovim
    nvim "$config_dir/$sub_dir"
end
