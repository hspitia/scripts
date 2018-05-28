#!/bin/bash

ps -A | grep battery_check;
ps -A | grep battery_check | tr -s ' ' | cut -d' ' -f2 | xargs -I {} kill {};
ps -A | grep battery_check;
