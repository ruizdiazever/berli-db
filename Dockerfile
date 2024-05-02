FROM postgres:latest

# DATABASE
LABEL maintainer="berli"
ENV POSTGRES_PASSWORD berliberli
COPY ./migrations/sql/*.sql /docker-entrypoint-initdb.d/

EXPOSE 5433
