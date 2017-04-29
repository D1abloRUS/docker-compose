#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE USER checker WITH password 'checker';
  CREATE DATABASE checker;
  GRANT ALL PRIVILEGES ON DATABASE checker TO checker;
EOSQL
