# Start with the official PostgreSQL image
FROM postgres:16

# Install pgBackRest and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    pgbackrest \
    pgcli \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /pgbackrest

RUN chown -R postgres:postgres /pgbackrest
