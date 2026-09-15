if not status is-interactive
    exit
end

set -g __done_version 1.19.1-hyprland

function __done_get_focused_window_id
    if test -n "$HYPRLAND_INSTANCE_SIGNATURE"
        hyprctl activewindow | awk '/^\tpid: / {print $2}'
    end
end

function __done_is_process_window_focused
    if test -n "$HYPRLAND_INSTANCE_SIGNATURE"
        set -l window_pid (hyprctl activewindow | awk '/^\tpid: / {print $2}')
        if test -n "$window_pid"
            and test "$__done_initial_window_id" -eq "$window_pid"
            return 0
        end
    end
    return 1
end

function __done_humanize_duration -a milliseconds
    set -l seconds (math --scale=0 "$milliseconds/1000" % 60)
    set -l minutes (math --scale=0 "$milliseconds/60000" % 60)
    set -l hours (math --scale=0 "$milliseconds/3600000")

    if test $hours -gt 0
        printf '%s' $hours'h '
    end
    if test $minutes -gt 0
        printf '%s' $minutes'm '
    end
    if test $seconds -gt 0
        printf '%s' $seconds's'
    end
end

# Initialize if Hyprland is active
if test -n "$HYPRLAND_INSTANCE_SIGNATURE"
    set __done_enabled
end

if set -q __done_enabled
    set -g __done_initial_window_id ''
    set -q __done_min_cmd_duration; or set -g __done_min_cmd_duration 5000
    set -q __done_exclude; or set -g __done_exclude '^git (?!push|pull|fetch)'
    set -q __done_notify_sound; or set -g __done_notify_sound 0
    set -q __done_notification_duration; or set -g __done_notification_duration 3000

    function __done_started --on-event fish_preexec
        set __done_initial_window_id (__done_get_focused_window_id)
    end

    function __done_ended --on-event fish_postexec
        set -l exit_status $status
        set -q cmd_duration; or set -l cmd_duration $CMD_DURATION

        if test $cmd_duration
            and test $cmd_duration -gt $__done_min_cmd_duration
            and not __done_is_process_window_focused

            # Skip if command matches exclude list
            for pattern in $__done_exclude
                if string match -qr $pattern $argv[1]
                    return
                end
            end

            set -l humanized_duration (__done_humanize_duration "$cmd_duration")
            set -l title "Done in $humanized_duration"
            set -l wd (string replace --regex "^$HOME" "~" (pwd))
            set -l message "$wd/ $argv[1]"

            if test $exit_status -ne 0
                set title "Failed ($exit_status) after $humanized_duration"
            end

            if type -q notify-send
                set -l urgency normal
                if test $exit_status -ne 0
                    set urgency critical
                end

                notify-send --hint=int:transient:1 --urgency=$urgency --icon=utilities-terminal --app-name=fish --expire-time=$__done_notification_duration "$title" "$message"
                
                if test "$__done_notify_sound" -eq 1
                    echo -e "\a"
                end
            else
                echo -e "\a"
            end
        end
    end
end

function __done_uninstall -e done_uninstall
    functions -e __done_ended
    functions -e __done_started
    functions -e __done_get_focused_window_id
    functions -e __done_is_process_window_focused
    functions -e __done_humanize_duration
    set -e __done_version
end