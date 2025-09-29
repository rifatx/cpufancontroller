#!/bin/bash

sudo cp ./fan_controller.sh /usr/local/bin
sudo cp ./fancontroller.service /ets/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable fancontroller.service
sudo systemctl start fancontroller.service

