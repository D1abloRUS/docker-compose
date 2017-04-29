#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE USER proxy WITH password 'proxy';
  CREATE DATABASE proxy;
  GRANT ALL PRIVILEGES ON DATABASE proxy TO proxy;
EOSQL

psql -v ON_ERROR_STOP=1 --username "proxy" <<-EOSQL
  CREATE TABLE IF NOT EXISTS country (country_id SERIAL UNIQUE PRIMARY KEY, country VARCHAR(2) UNIQUE NOT NULL);
  CREATE TABLE IF NOT EXISTS proxy (proxy_id SERIAL UNIQUE PRIMARY KEY, ip INET UNIQUE NOT NULL, port INT NOT NULL, country_id INT NOT NULL REFERENCES country(country_id), respone FLOAT NOT NULL, status BOOL NOT NULL DEFAULT 'true');
EOSQL
