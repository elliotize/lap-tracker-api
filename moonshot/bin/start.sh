#!/bin/sh

gem install bundler
cd /var/lap_tracker
bundle install
mkdir /etc/systemd/system/lap-tracker.service.d
curl http://169.254.169.254/latest/user-data/> /etc/systemd/system/lap-tracker.service.d/db.conf
systemctl daemon-reload
systemctl restart lap-tracker
