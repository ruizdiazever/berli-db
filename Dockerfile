FROM postgres:latest

# DATABASE
LABEL maintainer="berli"
ENV POSTGRES_PASSWORD 8FQGsf8hRu5FY88dMXTqNf8
ENV POSTGRES_USER ever
ENV POSTGRES_DB berli
COPY ./migrations/sql/*.sql /docker-entrypoint-initdb.d/

EXPOSE 5433
