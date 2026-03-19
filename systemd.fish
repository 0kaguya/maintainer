#!/usr/bin/fish
# Update systemd unit

source (status dirname)/maintainer.fish

for path in (print-deleted-files | grep -e '\.service')
    if not set -q daemon-reloaded
        sudo systemctl daemon-reload ||
            begin
                echo "Failed to reload systemd daemon." >&2
                exit 1
            end
        set -g daemon-reloaded 1
    end

    set -l service (get-service-name $path)
    if test (systemctl is-active $service) = active
        sudo systemctl disable --now $service
    end
end

for path in (print-commit-files | grep -e '\.service')
    if not set -q daemon-reloaded
        sudo systemctl daemon-reload ||
            begin
                echo "Failed to reload systemd daemon." >&2
                exit 1
            end
        set -g daemon-reloaded 1
    end

    set -l service (get-service-name $path)

    if test (systemctl is-active $service) = active
        sudo systemctl restart $service
    else
        sudo systemctl enable --now $service
    end
end
