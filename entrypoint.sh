#!/bin/bash

/usr/sbin/httpd &

cd /opt/server \
  && node WebQDS.js
