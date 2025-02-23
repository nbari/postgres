set shell := ["zsh", "-uc"]

# Get the current user's UID and GID
uid := `id -u`
gid := `id -g`

# Set the PGDATA directory
pgdata := "/db/16"

run: build
  mkdir -p db/log/{postgres,pgbackrest}
  mkdir -p config

  podman run --rm --name postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=secret \
  -e PGDATA={{ pgdata }} \
  -p 5432:5432 \
  -v $(pwd)/db:/db \
  -v $(pwd)/config/postgres:/etc/postgresql/config \
  -v $(pwd)/config/pgbackrest:/etc/pgbackrest \
  --userns keep-id:uid={{ uid }},gid={{ gid }} \
  --user {{ uid }}:{{ gid }} \
  --userns keep-id:uid=999,gid=999 \
  --user 999:999 \
  postgres-with-pgbackrest entrypoint.sh

build:
  podman build -t postgres-with-pgbackrest .

stanza:
  podman exec -it  postgres pgbackrest --stanza=test stanza-create

enter: stanza
  podman exec -it postgres bash

stop:
  podman stop postgres
