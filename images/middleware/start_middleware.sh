#!/bin/sh
# Run the middleware app as the app user.
exec gosu app node /home/app/middleware/app.js
