set shell := ["zsh", "-uc"]

# Get the current user's UID and GID
uid := `id -u`
gid := `id -g`

run: build
  mkdir -p pgdata/{16,pgbackrest}
  mkdir -p config
  mkdir -p log/{postgres,pgbackrest}

  podman run --rm --name postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=secret \
  -e PGDATA=/db/16 \
  -p 5432:5432 \
  -v $(pwd)/pgdata/16:/db/16 \
  -v $(pwd)/pgdata/pgbackrest:/pgbackrest \
  -v $(pwd)/config/postgres:/etc/postgresql/config \
  -v $(pwd)/config/pgbackrest:/etc/pgbackrest \
  -v $(pwd)/log:/log \
  --userns keep-id:uid={{ uid }},gid={{ gid }} \
  --user {{ uid }}:{{ gid }} \
  --userns keep-id:uid=999,gid=999 \
  --user 999:999 \
  postgres-with-pgbackrest postgres \
  -c config_file=/etc/postgresql/config/postgresql.conf

build:
  podman build -t postgres-with-pgbackrest .

stanza:
  podman exec -it  postgres pgbackrest --stanza=test stanza-create

enter: stanza
  podman exec -it postgres bash
