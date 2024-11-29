# postgres

postgres + pgbackrest sandbox

Usage:

```
just run
```

This will build the container and start it. The database will be available at
`localhost:5432` with user `postgres` and password `secret`.

To enter the container:

```
just enter
```

## Requirements

- podman
- just

## PgBackRest

Create full backup

```sh
pgbackrest backup
```

Restore to latest backup:

```sh
pgbackrest --delta --log-level-console=info --type=immediate --target-action=promote restore
```
> If need to restore to another backup use `--set=<id>`

Point-in-time recovery:

```sh
pgbackrest --delta --log-level-console=info --type=time --target="2024-11-29 07:28:05+00" --target-action=promote restore

```
