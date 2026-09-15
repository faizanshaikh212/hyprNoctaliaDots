function flat --description 'Create Flatpak shortcuts for rofi menu'
    set -l src_dir /var/lib/flatpak/exports/share/applications
    set -l dest_dir ~/.local/share/applications
    if test -d $src_dir
        mkdir -p $dest_dir
        # Create symlinks (-s), recursively (-r), and do not overwrite existing files (-n)
        cp -rsn $src_dir/*.desktop $dest_dir/ 2>/dev/null
        echo "✓ Flatpak shortcuts synced to Rofi menu successfully."
    else
        echo "✗ Flatpak export directory not found."
    end
end
