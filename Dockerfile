FROM postgres:latest

RUN apt-get update && apt-get install -y python3 python3-psycopg2

COPY ./init.sql /docker-entrypoint-initdb.d/
COPY ./script.py /usr/src/app/script.py

WORKDIR /usr/src/app

EXPOSE 5432
