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
