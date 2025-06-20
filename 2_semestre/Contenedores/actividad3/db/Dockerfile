FROM postgres:16-alpine

ENV POSTGRES_DB=actividad3
ENV POSTGRES_USER=actividad3
ENV POSTGRES_PASSWORD=supersecret

COPY init.sql /docker-entrypoint-initdb.d/
