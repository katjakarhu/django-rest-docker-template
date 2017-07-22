# Project name must be given as command line argument
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi
# Set project name
name=$1

# Create and enter the project directory
mkdir $name
cd $name

# Write project name to Dockerfile and docker-command.sh
perl -pi -e 's/{name}/'$name'/g' ../settings/Dockerfile
perl -pi -e 's/{name}/'$name'/g' ../settings/docker-command.sh

# Move docker files to the project directory
cp ../settings/docker-command.sh .
cp ../settings/docker-compose.yml .
cp ../settings/.dockerignore .
cp ../settings/Dockerfile .

# Add gitingore to project
cp ../.gitignore .


# Create a virtualenv to isolate our package dependencies locally
virtualenv env
source env/bin/activate

# Install Django and Django REST framework into the virtualenv
pip install django
pip install djangorestframework
pip install psycopg2
pip install django-sslserver
pip install gunicorn
pip install python-openid
pip install django-allauth

# Set up a new project with a single application
django-admin.py startproject $name

# Freeze requirements
pip freeze > $name/requirements.txt

# Set database to Postgres in settings.py
sqlite=`cat ../settings/db_sqlite.txt`
postgres=`cat ../settings/db_postgres.txt`
perl -0777 -pi -e "s/$sqlite/$postgres/g" $name/$name/settings.py

# Add items to installed apps in settings.py
apps=`cat ../settings/installed_apps`
marker='(.)django\.contrib\.staticfiles(.)\,'
perl -pi -e "s/$marker/$apps/g" $name/$name/settings.py

# Add items to urls.py
urls=`cat ../settings/urls`
perl -pi -e "s!]!$urls!g" $name/$name/urls.py

# Add settings to the end of settings.py
settings=`cat ../settings/settings`
echo $settings >> $name/$name/settings.py

