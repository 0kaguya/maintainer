#!/usr/bin/fish
# Sync current project with root.

source (status dirname)/maintainer.fish

sudo rsync -av ./ / --exclude="/$(scripts-dir)" (rsync-ignore-git)

for file in (print-deleted-files)
    sudo rm -f -- "/$file"
end
