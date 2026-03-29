#!/usr/bin/fish
# vim: smarttab shiftwidth=2

# Source guard.
if not set -q _MAINTAINER_H
    set -g _MAINTAINER_H 1
else
    # Exit this file. Fish is different from bash/zsh.
    exit 0
end

function get-service-name -a path
    if string match '*.conf' (basename $path)
        # Of the shape `.../*.service.d/*.conf`.
        basename (dirname $path) .d
    else
        echo (basename $path)
    end
end

function print-commit-files
    git diff-tree -r --name-only --no-commit-id --diff-filter=d HEAD
end

function print-deleted-files
    git diff-tree -r --name-only --no-commit-id --diff-filter=D HEAD
end

function rsync-ignore-git
    # Print rsync parameters that exclude files that ignored by Git.
    printf '%s\n' --exclude='.git*' --filter=':- .gitignore'
end

function scripts-dir
    # Print this directory (usually .scripts/).
    set git_base "$(git rev-parse --show-toplevel)"
    realpath --relative-to="$git_base" "$(status dirname)"
end

function fail -a during
    echo "Failed: $during" >&2
    exit 1
end
