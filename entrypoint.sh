#!/bin/bash

# Start tail in the background so container doesn't exit immediately
tail -f /dev/null &

echo "Starting PostgreSQL..."
postgres -c config_file=/etc/postgresql/config/postgresql.conf

# Save the process ID of tail to ensure the container keeps running
TAIL_PID=$!

# Wait for a signal or other trigger to start PostgreSQL
wait "$TAIL_PID"
