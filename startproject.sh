# Create the project directory
mkdir $1
cd $1

# Create a virtualenv to isolate our package dependencies locally
virtualenv env
source env/bin/activate

# Install Django and Django REST framework into the virtualenv
pip install django
pip install djangorestframework

# Set up a new project with a single application
django-admin.py startproject $1

# Freeze requirements
pip freeze > requirements.txt