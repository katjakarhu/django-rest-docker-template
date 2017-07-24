# Setting up a Django REST Framework project with PostgreSQL, Docker and django-allauth

Create a new Django REST Framework project with django-allauth by running `startproject.sh <project name>`

It creates docker-compose.yml and Dockerfile, installs and freezes requirements, and configures settings.py and urls.py so that everything works "out-of-the-box".

Project can be then run with `docker-compose up`, which starts the PostgreSQL db and the web application.

