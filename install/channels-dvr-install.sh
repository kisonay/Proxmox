#!/usr/bin/env bash

# Copyright (c) 2021-2023 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y curl
$STD apt-get install -y chromium-browser
$STD apt-get install -y xvfb
msg_ok "Installed Dependencies"

msg_info "Installing Channels DVR"
cd /usr/local
mkdir -p channels-dvr
sudo chown $(id -u -n) channels-dvr
curl -f -s https://getchannels.com/dvr/setup.sh | sh
adduser $(id -u -n) video
adduser $(id -u -n) render
msg_ok "Installed Channels DVR"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get autoremove
$STD apt-get autoclean
msg_ok "Cleaned"