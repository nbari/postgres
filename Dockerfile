# Start with the official PostgreSQL image
FROM postgres:16

# Install pgBackRest and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    iproute2 \
    ca-certificates \
    netcat-openbsd \
    pgbackrest \
    pipx \
    procps \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Allow the postgres user to be a sudoer
RUN echo "postgres ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# switch to the postgres user
USER postgres

# Install pgcli via pipx
RUN pipx install pgcli && pipx ensurepath

# Add /usr/lib/postgresql/16/bin to PATH for the postgres user
RUN echo 'export PATH=$PATH:/usr/lib/postgresql/16/bin' >> $HOME/.profile

ENV PGBACKREST_STANZA=test

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
