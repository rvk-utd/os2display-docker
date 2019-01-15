#!/bin/sh
# Run the search_node app as the app user.
exec gosu app node /home/app/search_node/app.js
