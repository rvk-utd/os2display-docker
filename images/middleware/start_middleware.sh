#!/bin/sh
# Run the middleware app as the app user.
exec /sbin/setuser app node /home/app/middleware/app.js
