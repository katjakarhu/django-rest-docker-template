#!/bin/bash
# Project name
project={name}

# Postgres must be up and accepting command
# So, let's check for that before doing anything else
set -e

host=db
cmd=5432
export PGPASSWORD="docker"

until psql -h "$host" -U "docker" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Yay! Postgres is up - activating project"

# Collect static files
echo "Collect static files"
python3 $project/manage.py collectstatic --noinput

# Apply database migrations
echo "Apply database migrations"
python3 $project/manage.py makemigrations
python3 $project/manage.py migrate

# Start server
echo "Starting server"
python3 $project/manage.py runsslserver 0.0.0.0:8000
