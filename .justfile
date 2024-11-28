set shell := ["zsh", "-uc"]

# Get the current user's UID and GID
uid := `id -u`
gid := `id -g`

run:
  mkdir -p {pgdata,config,log/postgres}

  chmod 777 log/postgres

  podman run --rm --name postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=secret \
  -e PGDATA=/pgdata \
  -p 5432:5432 \
  -v $(pwd)/pgdata:/pgdata \
  -v $(pwd)/config:/etc/postgresql/config \
  -v $(pwd)/log:/log \
  --userns keep-id:uid={{ uid }},gid={{ gid }} \
  --user {{ uid }}:{{ gid }} \
  postgres:17 postgres \
  -c config_file=/etc/postgresql/config/postgresql.conf
