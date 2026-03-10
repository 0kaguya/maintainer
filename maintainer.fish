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
  set -l base "$(basename $path)"
  if test "override.conf" = "$base"
    # Of the shape `.../name.service.d/override.conf`.
    basename -s ".d" $(dirname $path)
  else
    echo $base
  end
end

function get-commit-files
  # Beware that deleted files are also included. This is for, e.g., updating
  # systemd services for deleted overrides.
  git diff-tree -r --name-only --no-commit-id HEAD
end
