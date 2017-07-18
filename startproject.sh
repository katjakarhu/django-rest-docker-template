# Project name must be given as command line argument
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

# Write project name to Dockerfile and docker-command.sh
name=$1
sed -i -e 's/{name}/'$name'/g' Dockerfile
sed -i -e 's/{name}/'$name'/g' docker-command.sh


# Create the project directory
mkdir $name
cd $name


# Create a virtualenv to isolate our package dependencies locally
virtualenv env
source env/bin/activate

# Install Django and Django REST framework into the virtualenv
pip install django
pip install djangorestframework
pip install psycopg2
pip install django-sslserver
pip install gunicorn

# Set up a new project with a single application
django-admin.py startproject $name

# Freeze requirements
pip freeze > requirements.txt

# Set database to Postgres in project settings
sqlite=`cat ../settings/db_sqlite.txt`
postgres=`cat ../settings/db_postgres.txt`

perl -0777 -pe "s/$sqlite/$postgres/g" $name/$name/settings.py


