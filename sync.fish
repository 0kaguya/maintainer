#!/usr/bin/fish
# Sync current directory with root.

source (status dirname)/maintainer.fish

sudo rsync -av ./ / --exclude="/$(print_dir)" (rsync_ignore_git)

for file in (print-deleted-files)
    sudo rm -f -- "/$file"
end
