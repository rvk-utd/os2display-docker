#!/usr/bin/env bash

(sleep 10; exec tail -F -n 0 /home/app/middleware/logs/*) &
