# postgres
postgres sandbox

podman run --name base \
  -e POSTGRES_USER=base \
  -e POSTGRES_PASSWORD=base \
  -e POSTGRES_HOST_AUTH_METHOD=trust \
  -e PGDATA=/pgdata \
  -p 5432:5432 \
  -v $(pwd)/pgdata:/pgdata \
  postgres:17
